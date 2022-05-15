//
//  DocWatchHelper.m
//  learns_ios
//
//  Created by 杨洋 on 23/5/2022.
//

#import "DocWatchHelper.h"
#import <sys/event.h>

@implementation DocWatchHelper
{
    CFFileDescriptorRef kqref;
    CFRunLoopSourceRef rls;
}

- (void)kqueueFired {
    int kq;
    struct kevent event;
    struct timespec timeout = { 0, 0 };
    int eventCount;
    
    // ???????? 不是 kqueue
    kq = CFFileDescriptorGetNativeDescriptor(self->kqref);
    assert(kq > 0);
    
    eventCount = kevent(kq, NULL, 0, &event, 1, &timeout);
   
    assert((eventCount >= 0) && (eventCount < 2));
    
    if (eventCount == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDocWatchHelperDocumentChanged object:self];
    }
    
    CFFileDescriptorEnableCallBacks(self->kqref, kCFFileDescriptorReadCallBack);
}

static void KQCallback(CFFileDescriptorRef kqRef, CFOptionFlags callBackTypes, void * info) {
    DocWatchHelper *helper = (DocWatchHelper *)(__bridge id)(CFTypeRef)info;
    [helper kqueueFired];
}

- (void)beginGeneratingDocuementNotificationsInPath:(NSString *)docPath {
    int dirFD;
    int kq;
    int retVal;
    struct kevent eventToAdd;
    CFFileDescriptorContext context = {
        0,
        (void *)(__bridge  CFTypeRef)self, NULL, NULL, NULL
    };
    dirFD = open([docPath fileSystemRepresentation], O_EVTONLY);
    assert(dirFD > 0);
    
    kq = kqueue();
    assert(kq > 0);
    
    
    /*
     struct kevent {
                uintptr_t ident;        identifier for this event
                short     filter;       filter for event
                u_short   flags;        action flags for kqueue
                u_int     fflags;       filter flag value
                intptr_t  data;         filter data value
                void      *udata;       opaque user data identifier
        };
     */
    
    // ident: Value used to identify this event. The exact interpretation is determined by the attached filter, but often is a file descriptor.
    eventToAdd.ident = dirFD;
    
    // filter: Identifies the kernel filter used to process this event. The pre-defined system filters are described below.
    // The predefined system filters are listed below.  Arguments may be passed to and from the filter via the fflags and data fields in the kevent structure.
    //
    //          EVFILT_READ   Takes a file descriptor as the identifier, and returns
    //                        whenever there is data available to read.  The behavior of
    //                        the filter is slightly different depending on the descrip-tor descriptor
    //                        tor type.
    //
    //                        Sockets
    //                            Sockets which have previously been passed to listen()
    //                            return when there is an incoming connection pending.
    //                            data contains the size of the listen backlog.
    //
    //                            Other socket descriptors return when there is data to
    //                            be read, subject to the SO_RCVLOWAT value of the
    //                            socket buffer.  This may be overridden with a per-fil-ter per-filter
    //                            ter low water mark at the time the filter is added by
    //                            setting the NOTE_LOWAT flag in fflags, and specifying
    //                            the new low water mark in data.  On return, data con-tains contains
    //                            tains the number of bytes of protocol data available
    //                            to read.
    //
    //                            If the read direction of the socket has shutdown, then
    //                            the filter also sets EV_EOF in flags, and returns the
    //                            socket error (if any) in fflags.  It is possible for
    //                            EOF to be returned (indicating the connection is gone)
    //                            while there is still data pending in the socket
    //                            buffer.
    //
    //                        Vnodes
    //                            Returns when the file pointer is not at the end of
    //                            file.  data contains the offset from current position
    //                            to end of file, and may be negative.
    //
    //                        Fifos, Pipes
    //                            Returns when the there is data to read; data contains
    //                            the number of bytes available.
    //
    //                            When the last writer disconnects, the filter will set
    //                            EV_EOF in flags.  This may be cleared by passing in
    //                            EV_CLEAR, at which point the filter will resume wait-ing waiting
    //                            ing for data to become available before returning.
    //
    //         EVFILT_WRITE   Takes a file descriptor as the identifier, and returns
    //                        whenever it is possible to write to the descriptor.  For
    //                        sockets, pipes and fifos, data will contain the amount of
    //                        space remaining in the write buffer.  The filter will set
    //                        EV_EOF when the reader disconnects, and for the fifo case,
    //                        this may be cleared by use of EV_CLEAR.  Note that this
    //                        filter is not supported for vnodes.
    //
    //                        For sockets, the low water mark and socket error handling
    //                        is identical to the EVFILT_READ case.
    //
    //         EVFILT_AIO     This filter is currently unsupported.
    //
    //         EVFILT_VNODE   Takes a file descriptor as the identifier and the events
    //                        to watch for in fflags, and returns when one or more of
    //                        the requested events occurs on the descriptor.  The events
    //                        to monitor are:
    //
    //                        NOTE_DELETE    The unlink() system call was called on the
    //                                       file referenced by the descriptor.
    //
    //                        NOTE_WRITE     A write occurred on the file referenced by
    //                                       the descriptor.
    //
    //                        NOTE_EXTEND    The file referenced by the descriptor was
    //                                       extended.
    //
    //                        NOTE_ATTRIB    The file referenced by the descriptor had
    //                                       its attributes changed.
    //
    //                        NOTE_LINK      The link count on the file changed.
    //
    //                        NOTE_RENAME    The file referenced by the descriptor was
    //                                       renamed.
    //
    //                        NOTE_REVOKE    Access to the file was revoked via
    //                                       revoke(2) or the underlying fileystem was
    //                                       unmounted.
    //
    //                        On return, fflags contains the events which triggered the
    //                        filter.
    //
    //         EVFILT_PROC    Takes the process ID to monitor as the identifier and the
    //                        events to watch for in fflags, and returns when the
    //                        process performs one or more of the requested events.  If
    //                        a process can normally see another process, it can attach
    //                        an event to it.  The events to monitor are:
    //
    //                        NOTE_EXIT
    //                           The process has exited.
    //
    //                        NOTE_FORK
    //                           The process created a child process via fork(2) or sim-ilar similar
    //                           ilar call.
    //
    //                        NOTE_EXEC
    //                           The process executed a new process via execve(2) or
    //                           similar call.
    //
    //                        NOTE_SIGNAL
    //                           The process was sent a signal. Status can be checked
    //                           via waitpid(2) or similar call.
    //
    //                        NOTE_REAP
    //                           The process was reaped by the parent via wait(2) or
    //                           similar call.
    //
    //                        On return, fflags contains the events which triggered the
    //                        filter.
    //
    //         EVFILT_SIGNAL  Takes the signal number to monitor as the identifier and
    //                        returns when the given signal is delivered to the process.
    //                        This coexists with the signal() and sigaction() facili-ties, facilities,
    //                        ties, and has a lower precedence.  The filter will record
    //                        all attempts to deliver a signal to a process, even if the
    //                        signal has been marked as SIG_IGN.  Event notification
    //                        happens after normal signal delivery processing.  data
    //                        returns the number of times the signal has occurred since
    //                        the last call to kevent().  This filter automatically sets
    //                        the EV_CLEAR flag internally.
    //
    //         EVFILT_TIMER   This filter is currently unsupported.
    eventToAdd.filter = EVFILT_VNODE;
    
    // flags: Actions to perform on the event. 新增、清除事件，下面是所有的Action：
    //EV_ADD         Adds the event to the kqueue.  Re-adding an existing event
    //    will modify the parameters of the original event, and not
    //    result in a duplicate entry.  Adding an event automati-cally automatically
    //    cally enables it, unless overridden by the EV_DISABLE
    //    flag.
    //
    //EV_ENABLE      Permit kevent() to return the event if it is triggered.
    //
    //EV_DISABLE     Disable the event so kevent() will not return it.  The
    //    filter itself is not disabled.
    //
    //EV_DELETE      Removes the event from the kqueue.  Events which are
    //    attached to file descriptors are automatically deleted on
    //    the last close of the descriptor.
    //
    //EV_RECEIPT     This flag is useful for making bulk changes to a kqueue
    //    without draining any pending events. When passed as input,
    //    it forces EV_ERROR to always be returned.  When a filter
    //    is successfully added. The data field will be zero.
    //
    //EV_ONESHOT     Causes the event to return only the first occurrence of
    //    the filter being triggered.  After the user retrieves the
    //    event from the kqueue, it is deleted.
    //
    //EV_CLEAR       After the event is retrieved by the user, its state is
    //    reset.  This is useful for filters which report state
    //    transitions instead of the current state.  Note that some
    //    filters may automatically set this flag internally.
    //
    //EV_EOF         Filters may set this flag to indicate filter-specific EOF
    //    condition.
    //
    //EV_ERROR       See RETURN VALUES below.
    eventToAdd.flags = EV_ADD | EV_CLEAR;
    
    // fflags: Filter-specific flags.
    eventToAdd.fflags = NOTE_WRITE;
    
    // data: Filter-specific data value.
    eventToAdd.data = 0;
    
    // udata: Opaque user-defined value passed through the kernel unchanged.
    eventToAdd.udata = NULL;
    
    // 参数：
    // https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man2/kevent.2.html
    // kevent(<#int kq#>, <#const struct kevent *changelist#>, <#int nchanges#>, <#struct kevent *eventlist#>, <#int nevents#>, <#const struct timespec *timeout#>)
    // kq: kqueue, The kqueue() system call creates a new kernel event queue and returns a descriptor.
    // The queue is not inherited by a child created with fork(2).
    // The changelist argument is a pointer to an array of kevent structures, as defined in <sys/event.h>.
    // All changes contained in the changelist are applied before any pending events are read from the queue.
    // The nchanges argument gives the size of changelist.
    // The eventlist argument is a pointer to an array of kevent structures.
    // The nevents argument determines the size of eventlist.  If timeout is a non-NULL pointer, it specifies a maximum interval to wait for an event, which will be interpreted as a struct timespec.
    // If timeout is a NULL pointer, kevent() waits indefinitely.  To effect a poll, the timeout argument should be non-NULL, pointing to a zero-valued timespec structure.
    // The same array may be used for the changelist and eventlist.
    // return any pending events to the user.
    retVal = kevent(kq, &eventToAdd, 1, NULL, 0, NULL);
    assert(retVal > 0);
    
    self->kqref = CFFileDescriptorCreate(NULL, dirFD, true, KQCallback, &context);
    rls = CFFileDescriptorCreateRunLoopSource(NULL, self->kqref, 0);
    assert(rls != NULL);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), rls, kCFRunLoopDefaultMode);
    CFRelease(rls);
    
    CFFileDescriptorEnableCallBacks(self->kqref, kCFFileDescriptorReadCallBack);
}

- (void)dealloc {
    self.path = nil;
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), rls, kCFRunLoopDefaultMode);
    CFFileDescriptorDisableCallBacks(self->kqref, kCFFileDescriptorReadCallBack);
}

+ (instancetype)watcherForPath:(NSString *)aPath {
    DocWatchHelper *watcher = [[self alloc] init];
    watcher.path = aPath;
    [watcher beginGeneratingDocuementNotificationsInPath:aPath];
    return watcher;
}

@end
