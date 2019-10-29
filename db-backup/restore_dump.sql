create user develop with SUPERUSER PASSWORD '852258';
create table django_migrations
(
    id      serial                   not null
        constraint django_migrations_pkey
            primary key,
    app     varchar(255)             not null,
    name    varchar(255)             not null,
    applied timestamp with time zone not null
);

alter table django_migrations
    owner to develop;

create table django_content_type
(
    id        serial       not null
        constraint django_content_type_pkey
            primary key,
    app_label varchar(100) not null,
    model     varchar(100) not null,
    constraint django_content_type_app_label_model_76bd3d3b_uniq
        unique (app_label, model)
);

alter table django_content_type
    owner to develop;

create table auth_permission
(
    id              serial       not null
        constraint auth_permission_pkey
            primary key,
    name            varchar(255) not null,
    content_type_id integer      not null
        constraint auth_permission_content_type_id_2f476e4b_fk_django_co
            references django_content_type
            deferrable initially deferred,
    codename        varchar(100) not null,
    constraint auth_permission_content_type_id_codename_01ab375a_uniq
        unique (content_type_id, codename)
);

alter table auth_permission
    owner to develop;

create index auth_permission_content_type_id_2f476e4b
    on auth_permission (content_type_id);

create table auth_group
(
    id   serial       not null
        constraint auth_group_pkey
            primary key,
    name varchar(150) not null
        constraint auth_group_name_key
            unique
);

alter table auth_group
    owner to develop;

create index auth_group_name_a6ea08ec_like
    on auth_group (name);

create table auth_group_permissions
(
    id            serial  not null
        constraint auth_group_permissions_pkey
            primary key,
    group_id      integer not null
        constraint auth_group_permissions_group_id_b120cbf9_fk_auth_group_id
            references auth_group
            deferrable initially deferred,
    permission_id integer not null
        constraint auth_group_permissio_permission_id_84c5c92e_fk_auth_perm
            references auth_permission
            deferrable initially deferred,
    constraint auth_group_permissions_group_id_permission_id_0cd325b0_uniq
        unique (group_id, permission_id)
);

alter table auth_group_permissions
    owner to develop;

create index auth_group_permissions_group_id_b120cbf9
    on auth_group_permissions (group_id);

create index auth_group_permissions_permission_id_84c5c92e
    on auth_group_permissions (permission_id);

create table auth_user
(
    id           serial                   not null
        constraint auth_user_pkey
            primary key,
    password     varchar(128)             not null,
    last_login   timestamp with time zone,
    is_superuser boolean                  not null,
    username     varchar(150)             not null
        constraint auth_user_username_key
            unique,
    first_name   varchar(30)              not null,
    last_name    varchar(150)             not null,
    email        varchar(254)             not null,
    is_staff     boolean                  not null,
    is_active    boolean                  not null,
    date_joined  timestamp with time zone not null
);

alter table auth_user
    owner to develop;

create index auth_user_username_6821ab7c_like
    on auth_user (username);

create table auth_user_groups
(
    id       serial  not null
        constraint auth_user_groups_pkey
            primary key,
    user_id  integer not null
        constraint auth_user_groups_user_id_6a12ed8b_fk_auth_user_id
            references auth_user
            deferrable initially deferred,
    group_id integer not null
        constraint auth_user_groups_group_id_97559544_fk_auth_group_id
            references auth_group
            deferrable initially deferred,
    constraint auth_user_groups_user_id_group_id_94350c0c_uniq
        unique (user_id, group_id)
);

alter table auth_user_groups
    owner to develop;

create index auth_user_groups_user_id_6a12ed8b
    on auth_user_groups (user_id);

create index auth_user_groups_group_id_97559544
    on auth_user_groups (group_id);

create table auth_user_user_permissions
(
    id            serial  not null
        constraint auth_user_user_permissions_pkey
            primary key,
    user_id       integer not null
        constraint auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id
            references auth_user
            deferrable initially deferred,
    permission_id integer not null
        constraint auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm
            references auth_permission
            deferrable initially deferred,
    constraint auth_user_user_permissions_user_id_permission_id_14a6b632_uniq
        unique (user_id, permission_id)
);

alter table auth_user_user_permissions
    owner to develop;

create index auth_user_user_permissions_user_id_a95ead1b
    on auth_user_user_permissions (user_id);

create index auth_user_user_permissions_permission_id_1fbb5f2c
    on auth_user_user_permissions (permission_id);

create table django_admin_log
(
    id              serial                   not null
        constraint django_admin_log_pkey
            primary key,
    action_time     timestamp with time zone not null,
    object_id       text,
    object_repr     varchar(200)             not null,
    action_flag     smallint                 not null
        constraint django_admin_log_action_flag_check
            check (action_flag >= 0),
    change_message  text                     not null,
    content_type_id integer
        constraint django_admin_log_content_type_id_c4bce8eb_fk_django_co
            references django_content_type
            deferrable initially deferred,
    user_id         integer                  not null
        constraint django_admin_log_user_id_c564eba6_fk_auth_user_id
            references auth_user
            deferrable initially deferred
);

alter table django_admin_log
    owner to develop;

create index django_admin_log_content_type_id_c4bce8eb
    on django_admin_log (content_type_id);

create index django_admin_log_user_id_c564eba6
    on django_admin_log (user_id);

create table articles_article
(
    id            serial                   not null
        constraint articles_article_pkey
            primary key,
    article_title varchar(200)             not null,
    article_text  text                     not null,
    created_at    timestamp with time zone not null
);

alter table articles_article
    owner to develop;

create table articles_comment
(
    id           serial       not null
        constraint articles_comment_pkey
            primary key,
    author_name  varchar(50)  not null,
    comment_text varchar(200) not null,
    article_id   integer      not null
        constraint articles_comment_article_id_59ff1409_fk_articles_article_id
            references articles_article
            deferrable initially deferred
);

alter table articles_comment
    owner to develop;

create index articles_comment_article_id_59ff1409
    on articles_comment (article_id);

create table django_session
(
    session_key  varchar(40)              not null
        constraint django_session_pkey
            primary key,
    session_data text                     not null,
    expire_date  timestamp with time zone not null
);

alter table django_session
    owner to develop;

create index django_session_session_key_c0390e0f_like
    on django_session (session_key);

create index django_session_expire_date_a5c62663
    on django_session (expire_date);



