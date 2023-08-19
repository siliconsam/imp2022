
!----------------------------------------------------------------------
! new symbol: REQEXT
!----------------------------------------------------------------------
    %external %integer %fn %spec new symbol( %string(127) symbol name )

!----------------------------------------------------------------------
! reference symbol: REFEXT, ABSEXT
!----------------------------------------------------------------------
    %external %routine %spec reference symbol( %integer symbolid )

!----------------------------------------------------------------------
! get symbol name: REFEXT, ABSEXT
!----------------------------------------------------------------------
    %external %string(127)%fn %spec get symbol name( %integer symbolid )

!----------------------------------------------------------------------
! get symbol id: REFEXT, ABSEXT
!----------------------------------------------------------------------
    %external %integer %fn %spec get symbol id( %integer symbolid )

!----------------------------------------------------------------------
! get symbol valid: REFEXT, ABSEXT
!----------------------------------------------------------------------
    %external %byte %fn %spec get symbol valid( %integer symbolid )

!----------------------------------------------------------------------
! update all symbols
!----------------------------------------------------------------------
    %external %routine %spec update all symbols

!----------------------------------------------------------------------
! initialise symbols
!----------------------------------------------------------------------
    %external %routine %spec initialise symbols

!----------------------------------------------------------------------
! dump symbols
!----------------------------------------------------------------------
    %external %routine %spec dump symbols( %integer show all )

%endoffile
