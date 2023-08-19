
!----------------------------------------------------------------------
! external symbols
!----------------------------------------------------------------------
!----------------------------------------------------------------------
! new external: DEFEXTCODE, DEFEXTDATA
!----------------------------------------------------------------------
    %external %integer %fn %spec new external( %string(127) external name )

!----------------------------------------------------------------------
! get external name: DEFEXTCODE, DEFEXTDATA
!----------------------------------------------------------------------
    %external %string(127)%fn %spec get external name( %integer externalid )

!----------------------------------------------------------------------
! get external id: DEFEXTCODE, DEFEXTDATA
!----------------------------------------------------------------------
    %external %integer %fn %spec get external id( %integer externalid )

!----------------------------------------------------------------------
! associate local: DEFEXTCODE, FIXUP, DEFEXTDATA, LABEL
!----------------------------------------------------------------------
    %external %routine %spec associate local( %integer externalid,
                                              %integer localid,
                                              %string(127) name )

!----------------------------------------------------------------------
! get associate name: DEFEXTCODE, FIXUP, DEFEXTDATA, LABEL
!----------------------------------------------------------------------
    %external %string(127)%fn %spec get associate name( %integer externalid )

!----------------------------------------------------------------------
! get associate id: DEFEXTCODE, FIXUP, DEFEXTDATA, LABEL
!----------------------------------------------------------------------
    %external %integer %fn %spec get associate id( %integer externalid )

!----------------------------------------------------------------------
! dump externals
!----------------------------------------------------------------------
    %external %routine %spec dump externals

!----------------------------------------------------------------------
! initialise externals
!----------------------------------------------------------------------
    %external %routine %spec initialise externals

%endoffile
