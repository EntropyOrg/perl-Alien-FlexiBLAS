package Alien::FlexiBLAS;

use strict;
use warnings;
use base qw( Alien::Base );

our $VERSION = '0.001';

1;

__END__

=head1 NAME

Alien::FlexiBLAS - Find or build FlexiBLAS BLAS/LAPACK-switching library

=head1 SYNOPSIS

From L<ExtUtils::MakeMaker>:

 use ExtUtils::MakeMaker;
 use Alien::Base::Wrapper ();

 WriteMakefile(
   Alien::Base::Wrapper->new('Alien::FlexiBLAS')->mm_args2(
     NAME => 'FOO::XS',
     ...
   ),
 );

From L<Module::Build>:

 use Module::Build;
 use Alien::Base::Wrapper qw( Alien::FlexiBLAS !export );
 use Alien::FlexiBLAS;

 my $build = Module::Build->new(
   ...
   configure_requires => {
     'Alien::Base::Wrapper' => '0',
     'Alien::FlexiBLAS' => '0',
     ...
   },
   Alien::Base::Wrapper->mb_args,
   ...
 );

 $build->create_build_script;

From L<Inline::C> / L<Inline::CPP> script:

 use Inline 0.56 with => 'Alien::FlexiBLAS';

From L<Dist::Zilla>

 [@Filter]
 -bundle = @Basic
 -remove = MakeMaker

 [Prereqs / ConfigureRequires]
 Alien::FlexiBLAS = 0

 [MakeMaker::Awesome]
 header = use Alien::Base::Wrapper qw( Alien::FlexiBLAS !export );
 WriteMakefile_arg = Alien::Base::Wrapper->mm_args

From L<FFI::Platypus>:

 use FFI::Platypus;
 use Alien::FlexiBLAS;

 my $ffi = FFI::Platypus->new(
   lib => [ Alien::FlexiBLAS->dynamic_libs ],
 );

=head1 DESCRIPTION

This distribution provides FlexiBLAS so that it can be used by other
Perl distributions that are on CPAN.  It does this by first trying to
detect an existing install of FlexiBLAS on your system.  If found it
will use that.  If it cannot be found, the source code will be downloaded
from the internet and it will be installed in a private share location
for the use of other modules.

If you build/install the "shared" version, you can set the following
environment variables, which will be used to set the relevant CMake
configuration variables as documented in
L<https://github.com/mpimd-csc/flexiblas/blob/master/INSTALL.md>:

=over

=item *

C<SYS_BLAS_LIBRARY>

=item *

C<SYS_CBLAS_LIBRARY>

=item *

C<SYS_LAPACK_LIBRARY>

=item *

C<LAPACK_API_VERSION>

=item *

C<SYS_LAPACKE_LIBRARY>

=back

=head1 SEE ALSO

=over 4

=item L<FlexiBLAS|https://www.mpi-magdeburg.mpg.de/projects/flexiblas>

The FlexiBLAS home page.

=item L<Alien>

Documentation on the Alien concept itself.

=item L<Alien::Base>

The base class for this Alien.

=item L<Alien::Build::Manual::AlienUser>

Detailed manual for users of Alien classes.

=back
