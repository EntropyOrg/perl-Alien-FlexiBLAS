use strict;
use warnings;
use ExtUtils::MakeMaker;

my $abmm;
if (eval { require Alien::Build::MM; 1 }) {
  $abmm = Alien::Build::MM->new;
}

my $package_name = "Alien::FlexiBLAS";
(my $repo = $package_name) =~ s#::#-#g;
(my $from = $package_name) =~ s#::#/#g; $from = "lib/$from.pm";
my $dist_name = $repo;
$repo = "EntropyOrg/perl-$repo";
my %eumm_args = (
  NAME => $package_name,
  DISTNAME => $dist_name,
  VERSION_FROM => $from,
  ABSTRACT_FROM => $from,
  AUTHOR => 'PerlDL Developers <pdl-general@lists.sourceforge.net>',
  LICENSE=> "perl",
  MIN_PERL_VERSION => '5.016',
  CONFIGURE_REQUIRES => {
    'ExtUtils::MakeMaker' => '6.64', # TEST_REQUIRES
    "Alien::Build" => "0.32",
    "Alien::Build::MM" => "0.32",
    "Alien::Build::Plugin::Build::CMake" => "0.99",
    "Alien::Build::Plugin::Download::GitHub" => 0,
  },
  "BUILD_REQUIRES" => {
    "Alien::Build" => "0.32",
    "Alien::Build::MM" => "0.32",
    "ExtUtils::MakeMaker" => "6.52"
  },
  PREREQ_PM => {
    "Alien::Base" => "0.038",
  },
  TEST_REQUIRES => {
    "Test::More" => '0.88',
    "Test::Alien" => 0,
    "Test::Alien::Diag" => 0,
  },
  META_MERGE => {
    "meta-spec" => { version => 2 },
    resources => {
      homepage => 'http://pdl.perl.org/',
      bugtracker  => {web=>"https://github.com/$repo/issues"},
      repository  => {
        url => "git://github.com/$repo.git",
        type => 'git',
        web => "https://github.com/$repo",
      },
      x_IRC => 'irc://irc.perl.org/#pdl',
    },
  },
  clean => { FILES => join ' ', qw(MANIFEST.bak) },
);
%eumm_args = $abmm->mm_args(%eumm_args) if $abmm;
WriteMakefile(%eumm_args);

{ package
    MY;
  sub postamble {
    $abmm ? $abmm->mm_postamble(@_) : '';
  }
  sub install {
    ($abmm && $abmm->can('mm_install'))
      ? $abmm->mm_install(@_)
      : shift->SUPER::install(@_);
  }
}
