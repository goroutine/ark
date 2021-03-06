package Jobeet::Schema::ResultSet::Job;
use strict;
use warnings;
use utf8;
use parent 'DBIx::Class::ResultSet';

use Jobeet::Models;

# Result::Categoryで実装したのでここは削除
sub get_active_jobs {
   my $self = shift;

   $self = $self->search({ expires_at => { '>=', models('Schema')->now->strftime("%F %T") }, });
   $self = $self->search({}, {order_by => { -desc => 'expires_at'} });

   $self;
}

sub create_from_form {
    my ($self, $form) = @_;

    my $txn_guard = models('Schema')->txn_scope_guard;

    my $category_id = delete $form->params->{category};
    my $category = models('Schema::Category')->find({ id => $category_id })
        or die 'no such category_id: ', $category_id;

    my $job = $self->create({
        category_id => $category->id,
        %{ $form->params },
    });

    $txn_guard->commit;

    $job;
}

1;