proc panicln*(msg: string) =
    echo "panic: " & msg
    quit(-1)

when not defined(js) and not defined(nimscript):

    proc raisee*(exc: ref Exception, stks: seq[StackTraceEntry] = newseq[StackTraceEntry]()) =
        ## creates an exception object of type ``exceptn`` and sets its ``msg`` field
        ## to `message`. Returns the new exception object.
        #panicln exc.msg
        var stks2 : seq[StackTraceEntry] = stks
        var idx = stks2.len-1
        if stks2.len == 0:
            stks2 = getStackTraceEntries()
            idx = stks2.len - 1 - 1
        var s = exc.msg & "\n"
        while idx >= 0:
            let stk = stks2[idx]
            s &= "  #" & $(idx) & " " & $stk.procname & " " &  $stk.filename & ":" & $stk.line & "\n"
            idx -= 1
        panicln s
else:

    proc raisee*(exc: ref Exception, stks: seq[StackTraceEntry] = newseq[StackTraceEntry]()) =
        ## creates an exception object of type ``exceptn`` and sets its ``msg`` field
        ## to `message`. Returns the new exception object.
        #panicln exc.msg
        var s = exc.msg & "\n"
        for idx, stk in stks:
            s &= "  #" & $(idx) & " " & $stk.procname & " " &  $stk.filename & ":" & $stk.line & "\n"
        panicln s
