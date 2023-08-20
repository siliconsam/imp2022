%endoflist
{----------------------------------------------------------------------------}
    !
    ! NEW/DISPOSE routines used to acquire/free heap variables
    ! NEW/DISPOSE routines based on C library malloc/free routines
    !
    ! declare heap access routines
    !
{----------------------------------------------------------------------------}
    %external %routine        %spec impfree %c
                             %alias "_free" ( %integer templateaddr )
    %external %record(*) %map %spec impmalloc %c
                             %alias "_malloc" ( %integer s )
{----------------------------------------------------------------------------}
%list
%endoffile
