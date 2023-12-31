%endoflist
! IMP2020 Runtime Environment
! Copyright JD McMullin PhD, March 2021

    ! define the diagnostic flags
    %constant %integer pass2 = 2<<14
    %constant %integer mcode level D = (1<<13);    ! JDM peak level D debug diagnostics of Machine Code
    %constant %integer mcode level C = (1<<12);    ! JDM next level C debug diagnostics of Machine Code
    %constant %integer mcode level B = (1<<11);    ! JDM next level B debug diagnostics of Machine Code
    %constant %integer mcode level A = (1<<10);    ! JDM base level A debug diagnostics of Machine Code

    %constant %integer flags = mcode level D ! mcode level C ! mcode level B ! mcode level A ! 7

    %diagnose pass2 + flags;

%list
%endoffile
