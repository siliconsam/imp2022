%endoflist
{----------------------------------------------------------------------------}
    ! Simple trig library functions to demonstrate
    ! how to cross-link with the C library functions
    ! Copyright 2002 NB Information Limited
    !
    ! Declare useful trignometry functions
    !
{----------------------------------------------------------------------------}
    %external %long %real %fn %spec C Lib Cos %alias "_cos" ( %longreal r)
    %external %long %real %fn %spec C Lib Sine %alias "_sin" ( %longreal r)
{----------------------------------------------------------------------------}
%list
%endoffile
