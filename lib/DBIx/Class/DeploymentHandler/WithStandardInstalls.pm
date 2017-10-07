package DBIx::Class::DeploymentHandler::WithStandardInstalls;

use Moose::Role;

# ABSTRACT: Use standard install methods for result source installation

sub prepare_version_storage_install {
  my $self = shift;

  $self->prepare_resultsource_install({
    result_source => $self->version_storage->version_rs->result_source
  });
}

sub install_version_storage {
  my $self = shift;

  my $version = (shift||{})->{version} || $self->schema_version;

  $self->install_resultsource({
    result_source => $self->version_storage->version_rs->result_source,
    version       => $version,
  });
}

sub prepare_install {
  $_[0]->prepare_deploy;
  $_[0]->prepare_version_storage_install;
}

1;

__END__

vim: ts=2 sw=2 expandtab

=head1 DESCRIPTION

This includes the standard installation methods used by DeploymentHandler. It's
mostly here to make writing your own DeploymentHandler easier: in your own
class, you can say

  with 'DBIx::Class::DeploymentHandler::WithStandardInstalls';

and get the regular, uninteresting versions for free. See
L<DBIx::Class::DeploymentHandler> it in use.

=method prepare_version_storage_install

 $dh->prepare_version_storage_install

Creates the needed C<.sql> file to install the version storage and not the rest
of the tables

=method prepare_install

 $dh->prepare_install

First prepare all the tables to be installed and the prepare just the version
storage

=method install_version_storage

 $dh->install_version_storage

Install the version storage and not the rest of the tables
