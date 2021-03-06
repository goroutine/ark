package Jobeet::Schema::Result::Something;
use v5.20.3;
use strict;
use warnings;
use parent 'Jobeet::Schema::ResultBase';
use Jobeet::Schema::Types;

__PACKAGE__->table('jobeet_something');

__PACKAGE__->add_columns(
    json_column1 => VARCHAR(
        is_nullable => 0,
    ),

    json_column2 => VARCHAR(
        is_nullable => 0,
    ),
);

__PACKAGE__->inflate_json_column(qw/json_column1 json_column2/);

1;