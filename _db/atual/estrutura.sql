-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 10-Set-2018 às 21:08
-- Versão do servidor: 10.1.28-MariaDB
-- PHP Version: 7.0.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `direitofavoravel`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_actions`
--

CREATE TABLE `dfav_actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_authmap`
--

CREATE TABLE `dfav_authmap` (
  `aid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s dfav_users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_batch`
--

CREATE TABLE `dfav_batch` (
  `bid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_block`
--

CREATE TABLE `dfav_block` (
  `bid` int(11) NOT NULL COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  `css_class` varchar(255) NOT NULL DEFAULT '' COMMENT 'String containing the classes for the block.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_blocked_ips`
--

CREATE TABLE `dfav_blocked_ips` (
  `iid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_block_custom`
--

CREATE TABLE `dfav_block_custom` (
  `bid` int(10) UNSIGNED NOT NULL COMMENT 'The block’s dfav_block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The dfav_filter_format.format of the block body.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_block_node_type`
--

CREATE TABLE `dfav_block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from dfav_block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from dfav_block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from dfav_node_type.type.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_block_role`
--

CREATE TABLE `dfav_block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from dfav_block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from dfav_block.delta.',
  `rid` int(10) UNSIGNED NOT NULL COMMENT 'The user’s role ID from dfav_users_roles.rid.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache`
--

CREATE TABLE `dfav_cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_admin_menu`
--

CREATE TABLE `dfav_cache_admin_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for Administration menu to store client-side...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_block`
--

CREATE TABLE `dfav_cache_block` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_bootstrap`
--

CREATE TABLE `dfav_cache_bootstrap` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_field`
--

CREATE TABLE `dfav_cache_field` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Field module to store already built...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_filter`
--

CREATE TABLE `dfav_cache_filter` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_form`
--

CREATE TABLE `dfav_cache_form` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_image`
--

CREATE TABLE `dfav_cache_image` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_libraries`
--

CREATE TABLE `dfav_cache_libraries` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table to store library information.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_menu`
--

CREATE TABLE `dfav_cache_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_metatag`
--

CREATE TABLE `dfav_cache_metatag` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the generated meta tag output.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_page`
--

CREATE TABLE `dfav_cache_page` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_path`
--

CREATE TABLE `dfav_cache_path` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_token`
--

CREATE TABLE `dfav_cache_token` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for token information.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_update`
--

CREATE TABLE `dfav_cache_update` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Update module to store information...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_variable`
--

CREATE TABLE `dfav_cache_variable` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for variables.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_views`
--

CREATE TABLE `dfav_cache_views` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_cache_views_data`
--

CREATE TABLE `dfav_cache_views_data` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '1' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for views to store pre-rendered queries,...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_ckeditor_input_format`
--

CREATE TABLE `dfav_ckeditor_input_format` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'Name of the CKEditor role',
  `format` varchar(128) NOT NULL DEFAULT '' COMMENT 'Drupal filter format ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores CKEditor input format assignments';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_ckeditor_settings`
--

CREATE TABLE `dfav_ckeditor_settings` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'Name of the CKEditor profile',
  `settings` text COMMENT 'Profile settings'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores CKEditor profile settings';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_clientside_validation_settings`
--

CREATE TABLE `dfav_clientside_validation_settings` (
  `cvsid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for the clientside validation settings',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The type of setting: content_type, webform or custom',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The status for this form. 1 for enabled (validate), 0 for disabled (don’t validate)',
  `form_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'The form id these settings apply to',
  `settings` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for storing Clientside Validation Settings';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_conditional_fields`
--

CREATE TABLE `dfav_conditional_fields` (
  `id` int(11) NOT NULL COMMENT 'The primary identifier for a dependency.',
  `dependee` int(11) NOT NULL COMMENT 'The id of the dependee field instance.',
  `dependent` int(11) NOT NULL COMMENT 'The id of the dependent field instance.',
  `options` longblob NOT NULL COMMENT 'Serialized data containing the options for the dependency.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores dependencies between fields.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_ctools_css_cache`
--

CREATE TABLE `dfav_ctools_css_cache` (
  `cid` varchar(128) NOT NULL COMMENT 'The CSS ID this cache object belongs to.',
  `filename` varchar(255) DEFAULT NULL COMMENT 'The filename this CSS is stored in.',
  `css` longtext COMMENT 'CSS being stored.',
  `filter` tinyint(4) DEFAULT NULL COMMENT 'Whether or not this CSS needs to be filtered.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store CSS that must be non-volatile.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_ctools_object_cache`
--

CREATE TABLE `dfav_ctools_object_cache` (
  `sid` varchar(64) NOT NULL COMMENT 'The session ID this cache object belongs to.',
  `name` varchar(128) NOT NULL COMMENT 'The name of the object this cache is attached to.',
  `obj` varchar(128) NOT NULL COMMENT 'The type of the object this cache is attached to; this essentially represents the owner so that several sub-systems can use this cache.',
  `updated` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The time this cache was created or updated.',
  `data` longblob COMMENT 'Serialized data being stored.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A special cache used to store objects that are being...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_date_formats`
--

CREATE TABLE `dfav_date_formats` (
  `dfid` int(10) UNSIGNED NOT NULL COMMENT 'The date format identifier.',
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this format can be modified.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_date_format_locale`
--

CREATE TABLE `dfav_date_format_locale` (
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A dfav_languages.language for this format to be used with.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_date_format_type`
--

CREATE TABLE `dfav_date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this is a system provided format.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_collection_item`
--

CREATE TABLE `dfav_field_collection_item` (
  `item_id` int(11) NOT NULL COMMENT 'Primary Key: Unique field collection item ID.',
  `revision_id` int(11) NOT NULL COMMENT 'Default revision ID.',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of the field on the host entity embedding this entity.',
  `archived` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the field collection item is archived.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about field collection items.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_collection_item_revision`
--

CREATE TABLE `dfav_field_collection_item_revision` (
  `revision_id` int(11) NOT NULL COMMENT 'Primary Key: Unique revision ID.',
  `item_id` int(11) NOT NULL COMMENT 'Field collection item ID.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores revision information about field collection items.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_config`
--

CREATE TABLE `dfav_field_config` (
  `id` int(11) NOT NULL COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_config_instance`
--

CREATE TABLE `dfav_field_config_instance` (
  `id` int(11) NOT NULL COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_body`
--

CREATE TABLE `dfav_field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (body)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_alvo`
--

CREATE TABLE `dfav_field_data_field_alvo` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_alvo_value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 24 (field_alvo)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_category`
--

CREATE TABLE `dfav_field_data_field_category` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_category_value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 7 (field_category)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_date`
--

CREATE TABLE `dfav_field_data_field_date` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_date_value` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 28 (field_date)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_days_shifts`
--

CREATE TABLE `dfav_field_data_field_days_shifts` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_days_shifts_value` varchar(255) DEFAULT NULL,
  `field_days_shifts_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 30 (field_days_shifts)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_email`
--

CREATE TABLE `dfav_field_data_field_email` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_email_email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 19 (field_email)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_file`
--

CREATE TABLE `dfav_field_data_field_file` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_file_fid` int(10) UNSIGNED DEFAULT NULL COMMENT 'The dfav_file_managed.fid being referenced in this field.',
  `field_file_display` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
  `field_file_description` text COMMENT 'A description of the file.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 32 (field_file)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_image`
--

CREATE TABLE `dfav_field_data_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) UNSIGNED DEFAULT NULL COMMENT 'The dfav_file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) UNSIGNED DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) UNSIGNED DEFAULT NULL COMMENT 'The height of the image in pixels.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_image)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_info_left_sub_title`
--

CREATE TABLE `dfav_field_data_field_info_left_sub_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_info_left_sub_title_value` varchar(255) DEFAULT NULL,
  `field_info_left_sub_title_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 12 (field_info_left_sub_title)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_info_left_title`
--

CREATE TABLE `dfav_field_data_field_info_left_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_info_left_title_value` varchar(255) DEFAULT NULL,
  `field_info_left_title_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 10 (field_info_left_title)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_info_right_sub_title`
--

CREATE TABLE `dfav_field_data_field_info_right_sub_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_info_right_sub_title_value` varchar(255) DEFAULT NULL,
  `field_info_right_sub_title_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 11 (field_info_right_sub_title)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_info_right_title`
--

CREATE TABLE `dfav_field_data_field_info_right_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_info_right_title_value` varchar(255) DEFAULT NULL,
  `field_info_right_title_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 9 (field_info_right_title)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_investment`
--

CREATE TABLE `dfav_field_data_field_investment` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_investment_value` longtext,
  `field_investment_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 26 (field_investment)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_link`
--

CREATE TABLE `dfav_field_data_field_link` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_url` varchar(2048) DEFAULT NULL,
  `field_link_title` varchar(255) DEFAULT NULL,
  `field_link_attributes` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 5 (field_link)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_links_fc`
--

CREATE TABLE `dfav_field_data_field_links_fc` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_links_fc_value` int(11) DEFAULT NULL COMMENT 'The field collection item id.',
  `field_links_fc_revision_id` int(11) DEFAULT NULL COMMENT 'The field collection item revision id.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 31 (field_links_fc)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_link_2`
--

CREATE TABLE `dfav_field_data_field_link_2` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_2_url` varchar(2048) DEFAULT NULL,
  `field_link_2_title` varchar(255) DEFAULT NULL,
  `field_link_2_attributes` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 6 (field_link_2)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_link_facebook`
--

CREATE TABLE `dfav_field_data_field_link_facebook` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_facebook_url` varchar(2048) DEFAULT NULL,
  `field_link_facebook_title` varchar(255) DEFAULT NULL,
  `field_link_facebook_attributes` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 20 (field_link_facebook)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_link_linkedin`
--

CREATE TABLE `dfav_field_data_field_link_linkedin` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_linkedin_url` varchar(2048) DEFAULT NULL,
  `field_link_linkedin_title` varchar(255) DEFAULT NULL,
  `field_link_linkedin_attributes` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 22 (field_link_linkedin)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_link_twitter`
--

CREATE TABLE `dfav_field_data_field_link_twitter` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_twitter_url` varchar(2048) DEFAULT NULL,
  `field_link_twitter_title` varchar(255) DEFAULT NULL,
  `field_link_twitter_attributes` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 21 (field_link_twitter)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_name`
--

CREATE TABLE `dfav_field_data_field_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_name_value` varchar(255) DEFAULT NULL,
  `field_name_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 16 (field_name)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_profession`
--

CREATE TABLE `dfav_field_data_field_profession` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profession_value` varchar(255) DEFAULT NULL,
  `field_profession_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 17 (field_profession)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_specialty`
--

CREATE TABLE `dfav_field_data_field_specialty` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_specialty_value` varchar(255) DEFAULT NULL,
  `field_specialty_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 18 (field_specialty)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_tags`
--

CREATE TABLE `dfav_field_data_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 3 (field_tags)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_text_bottom`
--

CREATE TABLE `dfav_field_data_field_text_bottom` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_text_bottom_value` varchar(255) DEFAULT NULL,
  `field_text_bottom_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 15 (field_text_bottom)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_text_headlight`
--

CREATE TABLE `dfav_field_data_field_text_headlight` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_text_headlight_value` longtext,
  `field_text_headlight_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 25 (field_text_headlight)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_text_middle`
--

CREATE TABLE `dfav_field_data_field_text_middle` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_text_middle_value` varchar(255) DEFAULT NULL,
  `field_text_middle_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 14 (field_text_middle)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_text_top`
--

CREATE TABLE `dfav_field_data_field_text_top` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_text_top_value` varchar(255) DEFAULT NULL,
  `field_text_top_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 13 (field_text_top)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_workload`
--

CREATE TABLE `dfav_field_data_field_workload` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_workload_value` varchar(100) DEFAULT NULL,
  `field_workload_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 29 (field_workload)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_data_field_youtube`
--

CREATE TABLE `dfav_field_data_field_youtube` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_youtube_input` varchar(1024) DEFAULT NULL,
  `field_youtube_video_id` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 23 (field_youtube)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_group`
--

CREATE TABLE `dfav_field_group` (
  `id` int(11) NOT NULL COMMENT 'The primary identifier for a group',
  `identifier` varchar(255) NOT NULL DEFAULT '' COMMENT 'The unique string identifier for a group.',
  `group_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The name of this group.',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `mode` varchar(128) NOT NULL DEFAULT '',
  `parent_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The parent name for a group',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the group properties that do not warrant a dedicated column.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that contains field group entries and settings.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_body`
--

CREATE TABLE `dfav_field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (body)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_alvo`
--

CREATE TABLE `dfav_field_revision_field_alvo` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_alvo_value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 24 (field_alvo)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_category`
--

CREATE TABLE `dfav_field_revision_field_category` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_category_value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 7 (field_category)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_date`
--

CREATE TABLE `dfav_field_revision_field_date` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_date_value` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 28 (field_date)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_days_shifts`
--

CREATE TABLE `dfav_field_revision_field_days_shifts` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_days_shifts_value` varchar(255) DEFAULT NULL,
  `field_days_shifts_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 30 (field_days_shifts)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_email`
--

CREATE TABLE `dfav_field_revision_field_email` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_email_email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 19 (field_email)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_file`
--

CREATE TABLE `dfav_field_revision_field_file` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_file_fid` int(10) UNSIGNED DEFAULT NULL COMMENT 'The dfav_file_managed.fid being referenced in this field.',
  `field_file_display` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Flag to control whether this file should be displayed when viewing content.',
  `field_file_description` text COMMENT 'A description of the file.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 32 (field_file)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_image`
--

CREATE TABLE `dfav_field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) UNSIGNED DEFAULT NULL COMMENT 'The dfav_file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) UNSIGNED DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) UNSIGNED DEFAULT NULL COMMENT 'The height of the image in pixels.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_image)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_info_left_sub_title`
--

CREATE TABLE `dfav_field_revision_field_info_left_sub_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_info_left_sub_title_value` varchar(255) DEFAULT NULL,
  `field_info_left_sub_title_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 12 (field_info_left...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_info_left_title`
--

CREATE TABLE `dfav_field_revision_field_info_left_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_info_left_title_value` varchar(255) DEFAULT NULL,
  `field_info_left_title_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 10 (field_info_left...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_info_right_sub_title`
--

CREATE TABLE `dfav_field_revision_field_info_right_sub_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_info_right_sub_title_value` varchar(255) DEFAULT NULL,
  `field_info_right_sub_title_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 11 (field_info_right...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_info_right_title`
--

CREATE TABLE `dfav_field_revision_field_info_right_title` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_info_right_title_value` varchar(255) DEFAULT NULL,
  `field_info_right_title_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 9 (field_info_right...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_investment`
--

CREATE TABLE `dfav_field_revision_field_investment` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_investment_value` longtext,
  `field_investment_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 26 (field_investment)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_link`
--

CREATE TABLE `dfav_field_revision_field_link` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_url` varchar(2048) DEFAULT NULL,
  `field_link_title` varchar(255) DEFAULT NULL,
  `field_link_attributes` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 5 (field_link)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_links_fc`
--

CREATE TABLE `dfav_field_revision_field_links_fc` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_links_fc_value` int(11) DEFAULT NULL COMMENT 'The field collection item id.',
  `field_links_fc_revision_id` int(11) DEFAULT NULL COMMENT 'The field collection item revision id.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 31 (field_links_fc)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_link_2`
--

CREATE TABLE `dfav_field_revision_field_link_2` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_2_url` varchar(2048) DEFAULT NULL,
  `field_link_2_title` varchar(255) DEFAULT NULL,
  `field_link_2_attributes` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 6 (field_link_2)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_link_facebook`
--

CREATE TABLE `dfav_field_revision_field_link_facebook` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_facebook_url` varchar(2048) DEFAULT NULL,
  `field_link_facebook_title` varchar(255) DEFAULT NULL,
  `field_link_facebook_attributes` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 20 (field_link_facebook)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_link_linkedin`
--

CREATE TABLE `dfav_field_revision_field_link_linkedin` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_linkedin_url` varchar(2048) DEFAULT NULL,
  `field_link_linkedin_title` varchar(255) DEFAULT NULL,
  `field_link_linkedin_attributes` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 22 (field_link_linkedin)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_link_twitter`
--

CREATE TABLE `dfav_field_revision_field_link_twitter` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_link_twitter_url` varchar(2048) DEFAULT NULL,
  `field_link_twitter_title` varchar(255) DEFAULT NULL,
  `field_link_twitter_attributes` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 21 (field_link_twitter)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_name`
--

CREATE TABLE `dfav_field_revision_field_name` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_name_value` varchar(255) DEFAULT NULL,
  `field_name_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 16 (field_name)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_profession`
--

CREATE TABLE `dfav_field_revision_field_profession` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_profession_value` varchar(255) DEFAULT NULL,
  `field_profession_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 17 (field_profession)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_specialty`
--

CREATE TABLE `dfav_field_revision_field_specialty` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_specialty_value` varchar(255) DEFAULT NULL,
  `field_specialty_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 18 (field_specialty)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_tags`
--

CREATE TABLE `dfav_field_revision_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 3 (field_tags)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_text_bottom`
--

CREATE TABLE `dfav_field_revision_field_text_bottom` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_text_bottom_value` varchar(255) DEFAULT NULL,
  `field_text_bottom_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 15 (field_text_bottom)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_text_headlight`
--

CREATE TABLE `dfav_field_revision_field_text_headlight` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_text_headlight_value` longtext,
  `field_text_headlight_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 25 (field_text_headlight)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_text_middle`
--

CREATE TABLE `dfav_field_revision_field_text_middle` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_text_middle_value` varchar(255) DEFAULT NULL,
  `field_text_middle_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 14 (field_text_middle)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_text_top`
--

CREATE TABLE `dfav_field_revision_field_text_top` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_text_top_value` varchar(255) DEFAULT NULL,
  `field_text_top_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 13 (field_text_top)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_workload`
--

CREATE TABLE `dfav_field_revision_field_workload` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_workload_value` varchar(100) DEFAULT NULL,
  `field_workload_format` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 29 (field_workload)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_field_revision_field_youtube`
--

CREATE TABLE `dfav_field_revision_field_youtube` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) UNSIGNED NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) UNSIGNED NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_youtube_input` varchar(1024) DEFAULT NULL,
  `field_youtube_video_id` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 23 (field_youtube)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_file_managed`
--

CREATE TABLE `dfav_file_managed` (
  `fid` int(10) UNSIGNED NOT NULL COMMENT 'File ID.',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The dfav_users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` bigint(20) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_file_usage`
--

CREATE TABLE `dfav_file_usage` (
  `fid` int(10) UNSIGNED NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_filter`
--

CREATE TABLE `dfav_filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The dfav_filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_filter_format`
--

CREATE TABLE `dfav_filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_flood`
--

CREATE TABLE `dfav_flood` (
  `fid` int(11) NOT NULL COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_history`
--

CREATE TABLE `dfav_history` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The dfav_users.uid that read the dfav_node nid.',
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The dfav_node.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which dfav_users have read which dfav_nodes.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_image_effects`
--

CREATE TABLE `dfav_image_effects` (
  `ieid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The dfav_image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_image_styles`
--

CREATE TABLE `dfav_image_styles` (
  `isid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style machine name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_l10n_update_file`
--

CREATE TABLE `dfav_l10n_update_file` (
  `project` varchar(255) NOT NULL COMMENT 'A unique short name to identify the project.',
  `language` varchar(12) NOT NULL COMMENT 'Reference to the dfav_languages.language for this translation.',
  `type` varchar(50) NOT NULL DEFAULT '' COMMENT 'File origin: download or localfile',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Link to translation file for download.',
  `fileurl` varchar(255) NOT NULL DEFAULT '' COMMENT 'Link to translation file for download.',
  `uri` varchar(255) NOT NULL DEFAULT '' COMMENT 'File system path for importing the file.',
  `timestamp` int(11) DEFAULT '0' COMMENT 'Unix timestamp of the time the file was downloaded or saved to disk. Zero if not yet downloaded',
  `version` varchar(128) NOT NULL DEFAULT '' COMMENT 'Version tag of the downloaded file.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Status flag. TBD',
  `last_checked` int(11) DEFAULT '0' COMMENT 'Unix timestamp of the last time this translation was downloaded from or checked at remote server and confirmed to be the most recent release available.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='File and download information for project translations.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_l10n_update_project`
--

CREATE TABLE `dfav_l10n_update_project` (
  `name` varchar(255) NOT NULL COMMENT 'A unique short name to identify the project.',
  `project_type` varchar(50) NOT NULL COMMENT 'Project type, may be core, module, theme',
  `core` varchar(128) NOT NULL DEFAULT '' COMMENT 'Core compatibility string for this project.',
  `version` varchar(128) NOT NULL DEFAULT '' COMMENT 'Human readable name for project used on the interface.',
  `l10n_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Server path this project updates.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Status flag. If TRUE, translations of this module will be updated.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Update information for project translations.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_languages`
--

CREATE TABLE `dfav_languages` (
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'Language code, e.g. ’de’ or ’en-US’.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Language name in English.',
  `native` varchar(64) NOT NULL DEFAULT '' COMMENT 'Native language name.',
  `direction` int(11) NOT NULL DEFAULT '0' COMMENT 'Direction of language (Left-to-Right = 0, Right-to-Left = 1).',
  `enabled` int(11) NOT NULL DEFAULT '0' COMMENT 'Enabled flag (1 = Enabled, 0 = Disabled).',
  `plurals` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of plural indexes in this language.',
  `formula` varchar(255) NOT NULL DEFAULT '' COMMENT 'Plural formula in PHP code to evaluate to get plural indexes.',
  `domain` varchar(128) NOT NULL DEFAULT '' COMMENT 'Domain to use for this language.',
  `prefix` varchar(128) NOT NULL DEFAULT '' COMMENT 'Path prefix to use for this language.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight, used in lists of languages.',
  `javascript` varchar(64) NOT NULL DEFAULT '' COMMENT 'Location of JavaScript translation file.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of all available languages in the system.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_locales_source`
--

CREATE TABLE `dfav_locales_source` (
  `lid` int(11) NOT NULL COMMENT 'Unique identifier of this string.',
  `location` longtext COMMENT 'Drupal path in case of online discovered translations or file path in case of imported strings.',
  `textgroup` varchar(255) NOT NULL DEFAULT 'default' COMMENT 'A module defined group of translations, see hook_locale().',
  `source` blob NOT NULL COMMENT 'The original string in English.',
  `context` varchar(255) NOT NULL DEFAULT '' COMMENT 'The context this string applies to.',
  `version` varchar(20) NOT NULL DEFAULT 'none' COMMENT 'Version of Drupal, where the string was last used (for locales optimization).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='List of English source strings.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_locales_target`
--

CREATE TABLE `dfav_locales_target` (
  `lid` int(11) NOT NULL DEFAULT '0' COMMENT 'Source string ID. References dfav_locales_source.lid.',
  `translation` blob NOT NULL COMMENT 'Translation string value in this language.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'Language code. References dfav_languages.language.',
  `plid` int(11) NOT NULL DEFAULT '0' COMMENT 'Parent lid (lid of the previous string in the plural chain) in case of plural strings. References dfav_locales_source.lid.',
  `plural` int(11) NOT NULL DEFAULT '0' COMMENT 'Plural index number in case of plural strings.',
  `l10n_status` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores translated versions of strings.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_menu_custom`
--

CREATE TABLE `dfav_menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_menu_links`
--

CREATE TABLE `dfav_menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) UNSIGNED NOT NULL COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a dfav_menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in dfav_menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_menu_router`
--

CREATE TABLE `dfav_menu_router` (
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL DEFAULT '0' COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL DEFAULT '0' COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL DEFAULT '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext COMMENT 'The file to include for this element, usually the page callback function lives in this file.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps paths to various callbacks (access, page and title)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_metatag`
--

CREATE TABLE `dfav_metatag` (
  `entity_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to.',
  `entity_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The entity id this data is attached to.',
  `revision_id` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The revision_id for the entity object this data is attached to.',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language of the tag.',
  `data` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_metatag_config`
--

CREATE TABLE `dfav_metatag_config` (
  `cid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for a metatag configuration set.',
  `instance` varchar(255) NOT NULL DEFAULT '' COMMENT 'The machine-name of the configuration, typically entity-type:bundle.',
  `config` longblob NOT NULL COMMENT 'Serialized data containing the meta tag configuration.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Storage of meta tag configuration and defaults.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_node`
--

CREATE TABLE `dfav_node` (
  `nid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for a node.',
  `vid` int(10) UNSIGNED DEFAULT NULL COMMENT 'The current dfav_node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The dfav_node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The dfav_languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The dfav_users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_node_access`
--

CREATE TABLE `dfav_node_access` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The dfav_node.nid this record affects.',
  `gid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_node_revision`
--

CREATE TABLE `dfav_node_revision` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The dfav_node this version belongs to.',
  `vid` int(10) UNSIGNED NOT NULL COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The dfav_users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a dfav_node.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_node_type`
--

CREATE TABLE `dfav_node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a dfav_node of this type.',
  `has_title` tinyint(3) UNSIGNED NOT NULL COMMENT 'Boolean indicating whether this type uses the dfav_node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined dfav_node types.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_pathauto_state`
--

CREATE TABLE `dfav_pathauto_state` (
  `entity_type` varchar(32) NOT NULL COMMENT 'An entity type.',
  `entity_id` int(10) UNSIGNED NOT NULL COMMENT 'An entity ID.',
  `pathauto` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'The automatic alias status of the entity.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The status of each entity alias (whether it was...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_queue`
--

CREATE TABLE `dfav_queue` (
  `item_id` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_registry`
--

CREATE TABLE `dfav_registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_registry_file`
--

CREATE TABLE `dfav_registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_role`
--

CREATE TABLE `dfav_role` (
  `rid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_role_permission`
--

CREATE TABLE `dfav_role_permission` (
  `rid` int(10) UNSIGNED NOT NULL COMMENT 'Foreign Key: dfav_role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_semaphore`
--

CREATE TABLE `dfav_semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_sequences`
--

CREATE TABLE `dfav_sequences` (
  `value` int(10) UNSIGNED NOT NULL COMMENT 'The value of the sequence.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_sessions`
--

CREATE TABLE `dfav_sessions` (
  `uid` int(10) UNSIGNED NOT NULL COMMENT 'The dfav_users.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL DEFAULT '0' COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drupal’s session handlers read and write into the...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_shortcut_set`
--

CREATE TABLE `dfav_shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The dfav_menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_shortcut_set_users`
--

CREATE TABLE `dfav_shortcut_set_users` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The dfav_users.uid for this set.',
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The dfav_shortcut_set.set_name that will be displayed for this user.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to shortcut sets.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_system`
--

CREATE TABLE `dfav_system` (
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL DEFAULT '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL DEFAULT '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL DEFAULT '-1' COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of all modules, themes, and theme engines that are...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_taxonomy_index`
--

CREATE TABLE `dfav_taxonomy_index` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The dfav_node.nid this record tracks.',
  `tid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_taxonomy_term_data`
--

CREATE TABLE `dfav_taxonomy_term_data` (
  `tid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The dfav_taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The dfav_filter_format.format of the description.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this term in relation to other terms.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores term information.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_taxonomy_term_hierarchy`
--

CREATE TABLE `dfav_taxonomy_term_hierarchy` (
  `tid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary Key: The dfav_taxonomy_term_data.tid of the term.',
  `parent` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary Key: The dfav_taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_taxonomy_vocabulary`
--

CREATE TABLE `dfav_taxonomy_vocabulary` (
  `vid` int(10) UNSIGNED NOT NULL COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_trigger_assignments`
--

CREATE TABLE `dfav_trigger_assignments` (
  `hook` varchar(78) NOT NULL DEFAULT '' COMMENT 'Primary Key: The name of the internal Drupal hook; for example, node_insert.',
  `aid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Action’s dfav_actions.aid.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the trigger assignment in relation to other triggers.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps trigger to hook and operation assignments from...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_url_alias`
--

CREATE TABLE `dfav_url_alias` (
  `pid` int(10) UNSIGNED NOT NULL COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_users`
--

CREATE TABLE `dfav_users` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL DEFAULT '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) DEFAULT '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) DEFAULT NULL COMMENT 'The dfav_filter_format.format of the signature.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) DEFAULT NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign key: dfav_file_managed.fid of user’s picture.',
  `init` varchar(254) DEFAULT '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user data.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_users_roles`
--

CREATE TABLE `dfav_users_roles` (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary Key: dfav_users.uid for user.',
  `rid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Primary Key: dfav_role.rid for role.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_variable`
--

CREATE TABLE `dfav_variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_variable_store`
--

CREATE TABLE `dfav_variable_store` (
  `realm` varchar(50) NOT NULL DEFAULT '' COMMENT 'The realm domain of this variable.',
  `realm_key` varchar(50) NOT NULL DEFAULT '' COMMENT 'The realm key of this variable.',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longtext NOT NULL COMMENT 'The value of the variable.',
  `serialized` smallint(6) NOT NULL DEFAULT '1' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by modules using...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_views_display`
--

CREATE TABLE `dfav_views_display` (
  `vid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The view this display is attached to.',
  `id` varchar(64) NOT NULL DEFAULT '' COMMENT 'An identifier for this display; usually generated from the display_plugin, so should be something like page or page_1 or block_2, etc.',
  `display_title` varchar(64) NOT NULL DEFAULT '' COMMENT 'The title of the display, viewable by the administrator.',
  `display_plugin` varchar(64) NOT NULL DEFAULT '' COMMENT 'The type of the display. Usually page, block or embed, but is pluggable so may be other things.',
  `position` int(11) DEFAULT '0' COMMENT 'The order in which this display is loaded.',
  `display_options` longtext COMMENT 'A serialized array of options for this display; it contains options that are generally only pertinent to that display plugin type.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each display attached to a view.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_views_view`
--

CREATE TABLE `dfav_views_view` (
  `vid` int(10) UNSIGNED NOT NULL COMMENT 'The view ID of the field, defined by the database.',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The unique name of the view. This is the primary field views are loaded from, and is used so that views may be internal and not necessarily in the database. May only be alphanumeric characters plus underscores.',
  `description` varchar(255) DEFAULT '' COMMENT 'A description of the view for the admin interface.',
  `tag` varchar(255) DEFAULT '' COMMENT 'A tag used to group/sort views in the admin interface',
  `base_table` varchar(64) NOT NULL DEFAULT '' COMMENT 'What table this view is based on, such as node, user, comment, or term.',
  `human_name` varchar(255) DEFAULT '' COMMENT 'A human readable name used to be displayed in the admin interface',
  `core` int(11) DEFAULT '0' COMMENT 'Stores the drupal core version of the view.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the general data for a view.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_watchdog`
--

CREATE TABLE `dfav_watchdog` (
  `wid` int(11) NOT NULL COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The dfav_users.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example "user" or "page not found."',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Unix timestamp of when event occurred.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_webform`
--

CREATE TABLE `dfav_webform` (
  `nid` int(10) UNSIGNED NOT NULL COMMENT 'The node identifier of a webform.',
  `next_serial` int(10) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'The serial number to give to the next submission to this webform.',
  `confirmation` text NOT NULL COMMENT 'The confirmation message or URL displayed to the user after submitting a form.',
  `confirmation_format` varchar(255) DEFAULT NULL COMMENT 'The dfav_filter_format.format of the confirmation message.',
  `redirect_url` varchar(2048) DEFAULT '<confirmation>' COMMENT 'The URL a user is redirected to after submitting a form.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value of a webform for open (1) or closed (0).',
  `block` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether this form be available as a block.',
  `allow_draft` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether submissions to this form be saved as a draft.',
  `auto_save` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether submissions to this form should be auto-saved between pages.',
  `submit_notice` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value for whether to show or hide the previous submissions notification.',
  `confidential` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether to anonymize submissions.',
  `submit_text` varchar(255) DEFAULT NULL COMMENT 'The title of the submit button on the form.',
  `submit_limit` tinyint(4) NOT NULL DEFAULT '-1' COMMENT 'The number of submissions a single user is allowed to submit within an interval. -1 is unlimited.',
  `submit_interval` int(11) NOT NULL DEFAULT '-1' COMMENT 'The amount of time in seconds that must pass before a user can submit another submission within the set limit.',
  `total_submit_limit` int(11) NOT NULL DEFAULT '-1' COMMENT 'The total number of submissions allowed within an interval. -1 is unlimited.',
  `total_submit_interval` int(11) NOT NULL DEFAULT '-1' COMMENT 'The amount of time in seconds that must pass before another submission can be submitted within the set limit.',
  `progressbar_bar` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating if the bar should be shown as part of the progress bar.',
  `progressbar_page_number` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating if the page number should be shown as part of the progress bar.',
  `progressbar_percent` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating if the percentage complete should be shown as part of the progress bar.',
  `progressbar_pagebreak_labels` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating if the pagebreak labels should be included as part of the progress bar.',
  `progressbar_include_confirmation` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating if the confirmation page should count as a page in the progress bar.',
  `progressbar_label_first` varchar(255) DEFAULT NULL COMMENT 'Label for the first page of the progress bar.',
  `progressbar_label_confirmation` varchar(255) DEFAULT NULL COMMENT 'Label for the last page of the progress bar.',
  `preview` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value indicating if this form includes a page for previewing the submission.',
  `preview_next_button_label` varchar(255) DEFAULT NULL COMMENT 'The text for the button that will proceed to the preview page.',
  `preview_prev_button_label` varchar(255) DEFAULT NULL COMMENT 'The text for the button to go backwards from the preview page.',
  `preview_title` varchar(255) DEFAULT NULL COMMENT 'The title of the preview page, as used by the progress bar.',
  `preview_message` text NOT NULL COMMENT 'Text shown on the preview page of the form.',
  `preview_message_format` varchar(255) DEFAULT NULL COMMENT 'The dfav_filter_format.format of the preview page message.',
  `preview_excluded_components` text NOT NULL COMMENT 'Comma-separated list of component IDs that should not be included in this form’s confirmation page.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for storing additional properties for webform nodes.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_webform_component`
--

CREATE TABLE `dfav_webform_component` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `cid` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The identifier for this component within this node, starts at 0 for each node.',
  `pid` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'If this component has a parent fieldset, the cid of that component.',
  `form_key` varchar(128) DEFAULT NULL COMMENT 'When the form is displayed and processed, this key can be used to reference the results.',
  `name` text NOT NULL COMMENT 'The label for this component.',
  `type` varchar(16) DEFAULT NULL COMMENT 'The field type of this component (textfield, select, hidden, etc.).',
  `value` text NOT NULL COMMENT 'The default value of the component when displayed to the end-user.',
  `extra` text NOT NULL COMMENT 'Additional information unique to the display or processing of this component.',
  `required` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean flag for if this component is required.',
  `weight` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Determines the position of this component in the form.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about components for webform nodes.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_webform_conditional`
--

CREATE TABLE `dfav_webform_conditional` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `rgid` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The rule group identifier for this group of rules.',
  `andor` varchar(128) DEFAULT NULL COMMENT 'Whether to AND or OR the actions in this group. All actions within the same rgid should have the same andor value.',
  `weight` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Determines the position of this conditional compared to others.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds information about conditional logic.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_webform_conditional_actions`
--

CREATE TABLE `dfav_webform_conditional_actions` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `rgid` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The rule group identifier for this group of rules.',
  `aid` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The rule identifier for this conditional action.',
  `target_type` varchar(128) DEFAULT NULL COMMENT 'The type of target to be affected. Currently always "component". Indicates what type of ID the "target" column contains.',
  `target` varchar(128) DEFAULT NULL COMMENT 'The ID of the target to be affected. Typically a component ID.',
  `invert` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'If inverted, execute when rule(s) are false.',
  `action` varchar(128) DEFAULT NULL COMMENT 'The action to be performed on the target.',
  `argument` text COMMENT 'Optional argument for action.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds information about conditional actions.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_webform_conditional_rules`
--

CREATE TABLE `dfav_webform_conditional_rules` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `rgid` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The rule group identifier for this group of rules.',
  `rid` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The rule identifier for this conditional rule.',
  `source_type` varchar(128) DEFAULT NULL COMMENT 'The type of source on which the conditional is based. Currently always "component". Indicates what type of ID the "source" column contains.',
  `source` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The component ID being used in this condition.',
  `operator` varchar(128) DEFAULT NULL COMMENT 'Which operator (equal, contains, starts with, etc.) should be used for this comparison between the source and value?',
  `value` text COMMENT 'The value to be compared with source.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds information about conditional logic.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_webform_emails`
--

CREATE TABLE `dfav_webform_emails` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `eid` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The e-mail identifier for this row’s settings.',
  `email` text COMMENT 'The e-mail address that will be sent to upon submission. This may be an e-mail address, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `subject` text COMMENT 'The e-mail subject that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `from_name` text COMMENT 'The e-mail "from" name that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `from_address` text COMMENT 'The e-mail "from" e-mail address that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `template` text COMMENT 'A template that will be used for the sent e-mail. This may be a string or the special key "default", which will use the template provided by the theming layer.',
  `excluded_components` text NOT NULL COMMENT 'A list of components that will not be included in the [submission:values] token. A list of CIDs separated by commas.',
  `html` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Determines if the e-mail will be sent in an HTML format. Requires Mime Mail module.',
  `attachments` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Determines if the e-mail will include file attachments. Requires Mime Mail module.',
  `exclude_empty` tinyint(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Determines if the e-mail will include component with an empty value.',
  `extra` text NOT NULL COMMENT 'A serialized array of additional options for the e-mail configuration, including value mapping for the TO and FROM addresses for select lists.',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Whether this email is enabled.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds information regarding e-mails that should be sent...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_webform_last_download`
--

CREATE TABLE `dfav_webform_last_download` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The user identifier.',
  `sid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The last downloaded submission number.',
  `requested` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Timestamp of last download request.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores last submission number per user download.';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_webform_roles`
--

CREATE TABLE `dfav_webform_roles` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `rid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The role identifier.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds access information regarding which roles are...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_webform_submissions`
--

CREATE TABLE `dfav_webform_submissions` (
  `sid` int(10) UNSIGNED NOT NULL COMMENT 'The unique identifier for this submission.',
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `serial` int(10) UNSIGNED NOT NULL COMMENT 'The serial number of this submission.',
  `uid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The id of the user that completed this submission.',
  `is_draft` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this a draft of the submission?',
  `highest_valid_page` smallint(6) NOT NULL DEFAULT '0' COMMENT 'For drafts, the highest validated page number.',
  `submitted` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the form was first saved as draft or submitted.',
  `completed` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the form was submitted as complete (not draft).',
  `modified` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the form was last saved (complete or draft).',
  `remote_addr` varchar(128) DEFAULT NULL COMMENT 'The IP address of the user that submitted the form.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds general information about submissions outside of...';

-- --------------------------------------------------------

--
-- Estrutura da tabela `dfav_webform_submitted_data`
--

CREATE TABLE `dfav_webform_submitted_data` (
  `nid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `sid` int(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The unique identifier for this submission.',
  `cid` smallint(5) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'The identifier for this component within this node, starts at 0 for each node.',
  `no` varchar(128) NOT NULL DEFAULT '0' COMMENT 'Usually this value is 0, but if a field has multiple values (such as a time or date), it may require multiple rows in the database.',
  `data` mediumtext NOT NULL COMMENT 'The submitted value of this field, may be serialized for some components.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all submitted field data for webform submissions.';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dfav_actions`
--
ALTER TABLE `dfav_actions`
  ADD PRIMARY KEY (`aid`);

--
-- Indexes for table `dfav_authmap`
--
ALTER TABLE `dfav_authmap`
  ADD PRIMARY KEY (`aid`),
  ADD UNIQUE KEY `authname` (`authname`),
  ADD KEY `uid_module` (`uid`,`module`);

--
-- Indexes for table `dfav_batch`
--
ALTER TABLE `dfav_batch`
  ADD PRIMARY KEY (`bid`),
  ADD KEY `token` (`token`);

--
-- Indexes for table `dfav_block`
--
ALTER TABLE `dfav_block`
  ADD PRIMARY KEY (`bid`),
  ADD UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  ADD KEY `list` (`theme`,`status`,`region`,`weight`,`module`);

--
-- Indexes for table `dfav_blocked_ips`
--
ALTER TABLE `dfav_blocked_ips`
  ADD PRIMARY KEY (`iid`),
  ADD KEY `blocked_ip` (`ip`);

--
-- Indexes for table `dfav_block_custom`
--
ALTER TABLE `dfav_block_custom`
  ADD PRIMARY KEY (`bid`),
  ADD UNIQUE KEY `info` (`info`);

--
-- Indexes for table `dfav_block_node_type`
--
ALTER TABLE `dfav_block_node_type`
  ADD PRIMARY KEY (`module`,`delta`,`type`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `dfav_block_role`
--
ALTER TABLE `dfav_block_role`
  ADD PRIMARY KEY (`module`,`delta`,`rid`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `dfav_cache`
--
ALTER TABLE `dfav_cache`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_admin_menu`
--
ALTER TABLE `dfav_cache_admin_menu`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_block`
--
ALTER TABLE `dfav_cache_block`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_bootstrap`
--
ALTER TABLE `dfav_cache_bootstrap`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_field`
--
ALTER TABLE `dfav_cache_field`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_filter`
--
ALTER TABLE `dfav_cache_filter`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_form`
--
ALTER TABLE `dfav_cache_form`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_image`
--
ALTER TABLE `dfav_cache_image`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_libraries`
--
ALTER TABLE `dfav_cache_libraries`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_menu`
--
ALTER TABLE `dfav_cache_menu`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_metatag`
--
ALTER TABLE `dfav_cache_metatag`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_page`
--
ALTER TABLE `dfav_cache_page`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_path`
--
ALTER TABLE `dfav_cache_path`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_token`
--
ALTER TABLE `dfav_cache_token`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_update`
--
ALTER TABLE `dfav_cache_update`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_variable`
--
ALTER TABLE `dfav_cache_variable`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_views`
--
ALTER TABLE `dfav_cache_views`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_cache_views_data`
--
ALTER TABLE `dfav_cache_views_data`
  ADD PRIMARY KEY (`cid`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_ckeditor_input_format`
--
ALTER TABLE `dfav_ckeditor_input_format`
  ADD PRIMARY KEY (`name`,`format`);

--
-- Indexes for table `dfav_ckeditor_settings`
--
ALTER TABLE `dfav_ckeditor_settings`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `dfav_clientside_validation_settings`
--
ALTER TABLE `dfav_clientside_validation_settings`
  ADD PRIMARY KEY (`cvsid`),
  ADD UNIQUE KEY `cvs_form_id` (`form_id`),
  ADD KEY `clientside_validation_settings_form_id` (`form_id`),
  ADD KEY `clientside_validation_settings_type` (`type`),
  ADD KEY `clientside_validation_settings_form_id_type` (`form_id`,`type`);

--
-- Indexes for table `dfav_conditional_fields`
--
ALTER TABLE `dfav_conditional_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dfav_ctools_css_cache`
--
ALTER TABLE `dfav_ctools_css_cache`
  ADD PRIMARY KEY (`cid`);

--
-- Indexes for table `dfav_ctools_object_cache`
--
ALTER TABLE `dfav_ctools_object_cache`
  ADD PRIMARY KEY (`sid`,`obj`,`name`),
  ADD KEY `updated` (`updated`);

--
-- Indexes for table `dfav_date_formats`
--
ALTER TABLE `dfav_date_formats`
  ADD PRIMARY KEY (`dfid`),
  ADD UNIQUE KEY `formats` (`format`,`type`);

--
-- Indexes for table `dfav_date_format_locale`
--
ALTER TABLE `dfav_date_format_locale`
  ADD PRIMARY KEY (`type`,`language`);

--
-- Indexes for table `dfav_date_format_type`
--
ALTER TABLE `dfav_date_format_type`
  ADD PRIMARY KEY (`type`),
  ADD KEY `title` (`title`);

--
-- Indexes for table `dfav_field_collection_item`
--
ALTER TABLE `dfav_field_collection_item`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `dfav_field_collection_item_revision`
--
ALTER TABLE `dfav_field_collection_item_revision`
  ADD PRIMARY KEY (`revision_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `dfav_field_config`
--
ALTER TABLE `dfav_field_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `field_name` (`field_name`),
  ADD KEY `active` (`active`),
  ADD KEY `storage_active` (`storage_active`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `module` (`module`),
  ADD KEY `storage_module` (`storage_module`),
  ADD KEY `type` (`type`),
  ADD KEY `storage_type` (`storage_type`);

--
-- Indexes for table `dfav_field_config_instance`
--
ALTER TABLE `dfav_field_config_instance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  ADD KEY `deleted` (`deleted`);

--
-- Indexes for table `dfav_field_data_body`
--
ALTER TABLE `dfav_field_data_body`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `body_format` (`body_format`);

--
-- Indexes for table `dfav_field_data_field_alvo`
--
ALTER TABLE `dfav_field_data_field_alvo`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_alvo_value` (`field_alvo_value`);

--
-- Indexes for table `dfav_field_data_field_category`
--
ALTER TABLE `dfav_field_data_field_category`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_category_value` (`field_category_value`);

--
-- Indexes for table `dfav_field_data_field_date`
--
ALTER TABLE `dfav_field_data_field_date`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_data_field_days_shifts`
--
ALTER TABLE `dfav_field_data_field_days_shifts`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_days_shifts_format` (`field_days_shifts_format`);

--
-- Indexes for table `dfav_field_data_field_email`
--
ALTER TABLE `dfav_field_data_field_email`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_data_field_file`
--
ALTER TABLE `dfav_field_data_field_file`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_file_fid` (`field_file_fid`);

--
-- Indexes for table `dfav_field_data_field_image`
--
ALTER TABLE `dfav_field_data_field_image`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_image_fid` (`field_image_fid`);

--
-- Indexes for table `dfav_field_data_field_info_left_sub_title`
--
ALTER TABLE `dfav_field_data_field_info_left_sub_title`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_info_left_sub_title_format` (`field_info_left_sub_title_format`);

--
-- Indexes for table `dfav_field_data_field_info_left_title`
--
ALTER TABLE `dfav_field_data_field_info_left_title`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_info_left_title_format` (`field_info_left_title_format`);

--
-- Indexes for table `dfav_field_data_field_info_right_sub_title`
--
ALTER TABLE `dfav_field_data_field_info_right_sub_title`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_info_right_sub_title_format` (`field_info_right_sub_title_format`);

--
-- Indexes for table `dfav_field_data_field_info_right_title`
--
ALTER TABLE `dfav_field_data_field_info_right_title`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_info_right_title_format` (`field_info_right_title_format`);

--
-- Indexes for table `dfav_field_data_field_investment`
--
ALTER TABLE `dfav_field_data_field_investment`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_investment_format` (`field_investment_format`);

--
-- Indexes for table `dfav_field_data_field_link`
--
ALTER TABLE `dfav_field_data_field_link`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_data_field_links_fc`
--
ALTER TABLE `dfav_field_data_field_links_fc`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_links_fc_value` (`field_links_fc_value`),
  ADD KEY `field_links_fc_revision_id` (`field_links_fc_revision_id`);

--
-- Indexes for table `dfav_field_data_field_link_2`
--
ALTER TABLE `dfav_field_data_field_link_2`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_data_field_link_facebook`
--
ALTER TABLE `dfav_field_data_field_link_facebook`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_data_field_link_linkedin`
--
ALTER TABLE `dfav_field_data_field_link_linkedin`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_data_field_link_twitter`
--
ALTER TABLE `dfav_field_data_field_link_twitter`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_data_field_name`
--
ALTER TABLE `dfav_field_data_field_name`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_name_format` (`field_name_format`);

--
-- Indexes for table `dfav_field_data_field_profession`
--
ALTER TABLE `dfav_field_data_field_profession`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_profession_format` (`field_profession_format`);

--
-- Indexes for table `dfav_field_data_field_specialty`
--
ALTER TABLE `dfav_field_data_field_specialty`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_specialty_format` (`field_specialty_format`);

--
-- Indexes for table `dfav_field_data_field_tags`
--
ALTER TABLE `dfav_field_data_field_tags`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_tags_tid` (`field_tags_tid`);

--
-- Indexes for table `dfav_field_data_field_text_bottom`
--
ALTER TABLE `dfav_field_data_field_text_bottom`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_text_bottom_format` (`field_text_bottom_format`);

--
-- Indexes for table `dfav_field_data_field_text_headlight`
--
ALTER TABLE `dfav_field_data_field_text_headlight`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_text_headlight_format` (`field_text_headlight_format`);

--
-- Indexes for table `dfav_field_data_field_text_middle`
--
ALTER TABLE `dfav_field_data_field_text_middle`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_text_middle_format` (`field_text_middle_format`);

--
-- Indexes for table `dfav_field_data_field_text_top`
--
ALTER TABLE `dfav_field_data_field_text_top`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_text_top_format` (`field_text_top_format`);

--
-- Indexes for table `dfav_field_data_field_workload`
--
ALTER TABLE `dfav_field_data_field_workload`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_workload_format` (`field_workload_format`);

--
-- Indexes for table `dfav_field_data_field_youtube`
--
ALTER TABLE `dfav_field_data_field_youtube`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_youtube_video_id` (`field_youtube_video_id`);

--
-- Indexes for table `dfav_field_group`
--
ALTER TABLE `dfav_field_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identifier` (`identifier`),
  ADD KEY `group_name` (`group_name`);

--
-- Indexes for table `dfav_field_revision_body`
--
ALTER TABLE `dfav_field_revision_body`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `body_format` (`body_format`);

--
-- Indexes for table `dfav_field_revision_field_alvo`
--
ALTER TABLE `dfav_field_revision_field_alvo`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_alvo_value` (`field_alvo_value`);

--
-- Indexes for table `dfav_field_revision_field_category`
--
ALTER TABLE `dfav_field_revision_field_category`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_category_value` (`field_category_value`);

--
-- Indexes for table `dfav_field_revision_field_date`
--
ALTER TABLE `dfav_field_revision_field_date`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_revision_field_days_shifts`
--
ALTER TABLE `dfav_field_revision_field_days_shifts`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_days_shifts_format` (`field_days_shifts_format`);

--
-- Indexes for table `dfav_field_revision_field_email`
--
ALTER TABLE `dfav_field_revision_field_email`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_revision_field_file`
--
ALTER TABLE `dfav_field_revision_field_file`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_file_fid` (`field_file_fid`);

--
-- Indexes for table `dfav_field_revision_field_image`
--
ALTER TABLE `dfav_field_revision_field_image`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_image_fid` (`field_image_fid`);

--
-- Indexes for table `dfav_field_revision_field_info_left_sub_title`
--
ALTER TABLE `dfav_field_revision_field_info_left_sub_title`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_info_left_sub_title_format` (`field_info_left_sub_title_format`);

--
-- Indexes for table `dfav_field_revision_field_info_left_title`
--
ALTER TABLE `dfav_field_revision_field_info_left_title`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_info_left_title_format` (`field_info_left_title_format`);

--
-- Indexes for table `dfav_field_revision_field_info_right_sub_title`
--
ALTER TABLE `dfav_field_revision_field_info_right_sub_title`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_info_right_sub_title_format` (`field_info_right_sub_title_format`);

--
-- Indexes for table `dfav_field_revision_field_info_right_title`
--
ALTER TABLE `dfav_field_revision_field_info_right_title`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_info_right_title_format` (`field_info_right_title_format`);

--
-- Indexes for table `dfav_field_revision_field_investment`
--
ALTER TABLE `dfav_field_revision_field_investment`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_investment_format` (`field_investment_format`);

--
-- Indexes for table `dfav_field_revision_field_link`
--
ALTER TABLE `dfav_field_revision_field_link`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_revision_field_links_fc`
--
ALTER TABLE `dfav_field_revision_field_links_fc`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_links_fc_value` (`field_links_fc_value`),
  ADD KEY `field_links_fc_revision_id` (`field_links_fc_revision_id`);

--
-- Indexes for table `dfav_field_revision_field_link_2`
--
ALTER TABLE `dfav_field_revision_field_link_2`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_revision_field_link_facebook`
--
ALTER TABLE `dfav_field_revision_field_link_facebook`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_revision_field_link_linkedin`
--
ALTER TABLE `dfav_field_revision_field_link_linkedin`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_revision_field_link_twitter`
--
ALTER TABLE `dfav_field_revision_field_link_twitter`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_field_revision_field_name`
--
ALTER TABLE `dfav_field_revision_field_name`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_name_format` (`field_name_format`);

--
-- Indexes for table `dfav_field_revision_field_profession`
--
ALTER TABLE `dfav_field_revision_field_profession`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_profession_format` (`field_profession_format`);

--
-- Indexes for table `dfav_field_revision_field_specialty`
--
ALTER TABLE `dfav_field_revision_field_specialty`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_specialty_format` (`field_specialty_format`);

--
-- Indexes for table `dfav_field_revision_field_tags`
--
ALTER TABLE `dfav_field_revision_field_tags`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_tags_tid` (`field_tags_tid`);

--
-- Indexes for table `dfav_field_revision_field_text_bottom`
--
ALTER TABLE `dfav_field_revision_field_text_bottom`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_text_bottom_format` (`field_text_bottom_format`);

--
-- Indexes for table `dfav_field_revision_field_text_headlight`
--
ALTER TABLE `dfav_field_revision_field_text_headlight`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_text_headlight_format` (`field_text_headlight_format`);

--
-- Indexes for table `dfav_field_revision_field_text_middle`
--
ALTER TABLE `dfav_field_revision_field_text_middle`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_text_middle_format` (`field_text_middle_format`);

--
-- Indexes for table `dfav_field_revision_field_text_top`
--
ALTER TABLE `dfav_field_revision_field_text_top`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_text_top_format` (`field_text_top_format`);

--
-- Indexes for table `dfav_field_revision_field_workload`
--
ALTER TABLE `dfav_field_revision_field_workload`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_workload_format` (`field_workload_format`);

--
-- Indexes for table `dfav_field_revision_field_youtube`
--
ALTER TABLE `dfav_field_revision_field_youtube`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  ADD KEY `entity_type` (`entity_type`),
  ADD KEY `bundle` (`bundle`),
  ADD KEY `deleted` (`deleted`),
  ADD KEY `entity_id` (`entity_id`),
  ADD KEY `revision_id` (`revision_id`),
  ADD KEY `language` (`language`),
  ADD KEY `field_youtube_video_id` (`field_youtube_video_id`);

--
-- Indexes for table `dfav_file_managed`
--
ALTER TABLE `dfav_file_managed`
  ADD PRIMARY KEY (`fid`),
  ADD UNIQUE KEY `uri` (`uri`),
  ADD KEY `uid` (`uid`),
  ADD KEY `status` (`status`),
  ADD KEY `timestamp` (`timestamp`);

--
-- Indexes for table `dfav_file_usage`
--
ALTER TABLE `dfav_file_usage`
  ADD PRIMARY KEY (`fid`,`type`,`id`,`module`),
  ADD KEY `type_id` (`type`,`id`),
  ADD KEY `fid_count` (`fid`,`count`),
  ADD KEY `fid_module` (`fid`,`module`);

--
-- Indexes for table `dfav_filter`
--
ALTER TABLE `dfav_filter`
  ADD PRIMARY KEY (`format`,`name`),
  ADD KEY `list` (`weight`,`module`,`name`);

--
-- Indexes for table `dfav_filter_format`
--
ALTER TABLE `dfav_filter_format`
  ADD PRIMARY KEY (`format`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `status_weight` (`status`,`weight`);

--
-- Indexes for table `dfav_flood`
--
ALTER TABLE `dfav_flood`
  ADD PRIMARY KEY (`fid`),
  ADD KEY `allow` (`event`,`identifier`,`timestamp`),
  ADD KEY `purge` (`expiration`);

--
-- Indexes for table `dfav_history`
--
ALTER TABLE `dfav_history`
  ADD PRIMARY KEY (`uid`,`nid`),
  ADD KEY `nid` (`nid`);

--
-- Indexes for table `dfav_image_effects`
--
ALTER TABLE `dfav_image_effects`
  ADD PRIMARY KEY (`ieid`),
  ADD KEY `isid` (`isid`),
  ADD KEY `weight` (`weight`);

--
-- Indexes for table `dfav_image_styles`
--
ALTER TABLE `dfav_image_styles`
  ADD PRIMARY KEY (`isid`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `dfav_l10n_update_file`
--
ALTER TABLE `dfav_l10n_update_file`
  ADD PRIMARY KEY (`project`,`language`);

--
-- Indexes for table `dfav_l10n_update_project`
--
ALTER TABLE `dfav_l10n_update_project`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `dfav_languages`
--
ALTER TABLE `dfav_languages`
  ADD PRIMARY KEY (`language`),
  ADD KEY `list` (`weight`,`name`);

--
-- Indexes for table `dfav_locales_source`
--
ALTER TABLE `dfav_locales_source`
  ADD PRIMARY KEY (`lid`),
  ADD KEY `source_context` (`source`(30),`context`);

--
-- Indexes for table `dfav_locales_target`
--
ALTER TABLE `dfav_locales_target`
  ADD PRIMARY KEY (`language`,`lid`,`plural`),
  ADD KEY `lid` (`lid`),
  ADD KEY `plid` (`plid`),
  ADD KEY `plural` (`plural`);

--
-- Indexes for table `dfav_menu_custom`
--
ALTER TABLE `dfav_menu_custom`
  ADD PRIMARY KEY (`menu_name`);

--
-- Indexes for table `dfav_menu_links`
--
ALTER TABLE `dfav_menu_links`
  ADD PRIMARY KEY (`mlid`),
  ADD KEY `path_menu` (`link_path`(128),`menu_name`),
  ADD KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  ADD KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  ADD KEY `router_path` (`router_path`(128));

--
-- Indexes for table `dfav_menu_router`
--
ALTER TABLE `dfav_menu_router`
  ADD PRIMARY KEY (`path`),
  ADD KEY `fit` (`fit`),
  ADD KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  ADD KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`);

--
-- Indexes for table `dfav_metatag`
--
ALTER TABLE `dfav_metatag`
  ADD PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`language`),
  ADD KEY `type_revision` (`entity_type`,`revision_id`);

--
-- Indexes for table `dfav_metatag_config`
--
ALTER TABLE `dfav_metatag_config`
  ADD PRIMARY KEY (`cid`),
  ADD UNIQUE KEY `instance` (`instance`);

--
-- Indexes for table `dfav_node`
--
ALTER TABLE `dfav_node`
  ADD PRIMARY KEY (`nid`),
  ADD UNIQUE KEY `vid` (`vid`),
  ADD KEY `node_changed` (`changed`),
  ADD KEY `node_created` (`created`),
  ADD KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  ADD KEY `node_status_type` (`status`,`type`,`nid`),
  ADD KEY `node_title_type` (`title`,`type`(4)),
  ADD KEY `node_type` (`type`(4)),
  ADD KEY `uid` (`uid`),
  ADD KEY `tnid` (`tnid`),
  ADD KEY `translate` (`translate`),
  ADD KEY `language` (`language`);

--
-- Indexes for table `dfav_node_access`
--
ALTER TABLE `dfav_node_access`
  ADD PRIMARY KEY (`nid`,`gid`,`realm`);

--
-- Indexes for table `dfav_node_revision`
--
ALTER TABLE `dfav_node_revision`
  ADD PRIMARY KEY (`vid`),
  ADD KEY `nid` (`nid`),
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `dfav_node_type`
--
ALTER TABLE `dfav_node_type`
  ADD PRIMARY KEY (`type`);

--
-- Indexes for table `dfav_pathauto_state`
--
ALTER TABLE `dfav_pathauto_state`
  ADD PRIMARY KEY (`entity_type`,`entity_id`);

--
-- Indexes for table `dfav_queue`
--
ALTER TABLE `dfav_queue`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `name_created` (`name`,`created`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_registry`
--
ALTER TABLE `dfav_registry`
  ADD PRIMARY KEY (`name`,`type`),
  ADD KEY `hook` (`type`,`weight`,`module`);

--
-- Indexes for table `dfav_registry_file`
--
ALTER TABLE `dfav_registry_file`
  ADD PRIMARY KEY (`filename`);

--
-- Indexes for table `dfav_role`
--
ALTER TABLE `dfav_role`
  ADD PRIMARY KEY (`rid`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `name_weight` (`name`,`weight`);

--
-- Indexes for table `dfav_role_permission`
--
ALTER TABLE `dfav_role_permission`
  ADD PRIMARY KEY (`rid`,`permission`),
  ADD KEY `permission` (`permission`);

--
-- Indexes for table `dfav_semaphore`
--
ALTER TABLE `dfav_semaphore`
  ADD PRIMARY KEY (`name`),
  ADD KEY `value` (`value`),
  ADD KEY `expire` (`expire`);

--
-- Indexes for table `dfav_sequences`
--
ALTER TABLE `dfav_sequences`
  ADD PRIMARY KEY (`value`);

--
-- Indexes for table `dfav_sessions`
--
ALTER TABLE `dfav_sessions`
  ADD PRIMARY KEY (`sid`,`ssid`),
  ADD KEY `timestamp` (`timestamp`),
  ADD KEY `uid` (`uid`),
  ADD KEY `ssid` (`ssid`);

--
-- Indexes for table `dfav_shortcut_set`
--
ALTER TABLE `dfav_shortcut_set`
  ADD PRIMARY KEY (`set_name`);

--
-- Indexes for table `dfav_shortcut_set_users`
--
ALTER TABLE `dfav_shortcut_set_users`
  ADD PRIMARY KEY (`uid`),
  ADD KEY `set_name` (`set_name`);

--
-- Indexes for table `dfav_system`
--
ALTER TABLE `dfav_system`
  ADD PRIMARY KEY (`filename`),
  ADD KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  ADD KEY `type_name` (`type`,`name`);

--
-- Indexes for table `dfav_taxonomy_index`
--
ALTER TABLE `dfav_taxonomy_index`
  ADD KEY `term_node` (`tid`,`sticky`,`created`),
  ADD KEY `nid` (`nid`);

--
-- Indexes for table `dfav_taxonomy_term_data`
--
ALTER TABLE `dfav_taxonomy_term_data`
  ADD PRIMARY KEY (`tid`),
  ADD KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  ADD KEY `vid_name` (`vid`,`name`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `dfav_taxonomy_term_hierarchy`
--
ALTER TABLE `dfav_taxonomy_term_hierarchy`
  ADD PRIMARY KEY (`tid`,`parent`),
  ADD KEY `parent` (`parent`);

--
-- Indexes for table `dfav_taxonomy_vocabulary`
--
ALTER TABLE `dfav_taxonomy_vocabulary`
  ADD PRIMARY KEY (`vid`),
  ADD UNIQUE KEY `machine_name` (`machine_name`),
  ADD KEY `list` (`weight`,`name`);

--
-- Indexes for table `dfav_trigger_assignments`
--
ALTER TABLE `dfav_trigger_assignments`
  ADD PRIMARY KEY (`hook`,`aid`);

--
-- Indexes for table `dfav_url_alias`
--
ALTER TABLE `dfav_url_alias`
  ADD PRIMARY KEY (`pid`),
  ADD KEY `alias_language_pid` (`alias`,`language`,`pid`),
  ADD KEY `source_language_pid` (`source`,`language`,`pid`);

--
-- Indexes for table `dfav_users`
--
ALTER TABLE `dfav_users`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `access` (`access`),
  ADD KEY `created` (`created`),
  ADD KEY `mail` (`mail`),
  ADD KEY `picture` (`picture`);

--
-- Indexes for table `dfav_users_roles`
--
ALTER TABLE `dfav_users_roles`
  ADD PRIMARY KEY (`uid`,`rid`),
  ADD KEY `rid` (`rid`);

--
-- Indexes for table `dfav_variable`
--
ALTER TABLE `dfav_variable`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `dfav_variable_store`
--
ALTER TABLE `dfav_variable_store`
  ADD PRIMARY KEY (`realm`,`realm_key`,`name`),
  ADD KEY `realm_value` (`realm`,`realm_key`);

--
-- Indexes for table `dfav_views_display`
--
ALTER TABLE `dfav_views_display`
  ADD PRIMARY KEY (`vid`,`id`),
  ADD KEY `vid` (`vid`,`position`);

--
-- Indexes for table `dfav_views_view`
--
ALTER TABLE `dfav_views_view`
  ADD PRIMARY KEY (`vid`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `dfav_watchdog`
--
ALTER TABLE `dfav_watchdog`
  ADD PRIMARY KEY (`wid`),
  ADD KEY `type` (`type`),
  ADD KEY `uid` (`uid`),
  ADD KEY `severity` (`severity`);

--
-- Indexes for table `dfav_webform`
--
ALTER TABLE `dfav_webform`
  ADD PRIMARY KEY (`nid`);

--
-- Indexes for table `dfav_webform_component`
--
ALTER TABLE `dfav_webform_component`
  ADD PRIMARY KEY (`nid`,`cid`);

--
-- Indexes for table `dfav_webform_conditional`
--
ALTER TABLE `dfav_webform_conditional`
  ADD PRIMARY KEY (`nid`,`rgid`);

--
-- Indexes for table `dfav_webform_conditional_actions`
--
ALTER TABLE `dfav_webform_conditional_actions`
  ADD PRIMARY KEY (`nid`,`rgid`,`aid`);

--
-- Indexes for table `dfav_webform_conditional_rules`
--
ALTER TABLE `dfav_webform_conditional_rules`
  ADD PRIMARY KEY (`nid`,`rgid`,`rid`);

--
-- Indexes for table `dfav_webform_emails`
--
ALTER TABLE `dfav_webform_emails`
  ADD PRIMARY KEY (`nid`,`eid`);

--
-- Indexes for table `dfav_webform_last_download`
--
ALTER TABLE `dfav_webform_last_download`
  ADD PRIMARY KEY (`nid`,`uid`);

--
-- Indexes for table `dfav_webform_roles`
--
ALTER TABLE `dfav_webform_roles`
  ADD PRIMARY KEY (`nid`,`rid`);

--
-- Indexes for table `dfav_webform_submissions`
--
ALTER TABLE `dfav_webform_submissions`
  ADD PRIMARY KEY (`sid`),
  ADD UNIQUE KEY `sid_nid` (`sid`,`nid`),
  ADD UNIQUE KEY `nid_serial` (`nid`,`serial`),
  ADD KEY `nid_uid_sid` (`nid`,`uid`,`sid`),
  ADD KEY `nid_sid` (`nid`,`sid`);

--
-- Indexes for table `dfav_webform_submitted_data`
--
ALTER TABLE `dfav_webform_submitted_data`
  ADD PRIMARY KEY (`nid`,`sid`,`cid`,`no`),
  ADD KEY `nid` (`nid`),
  ADD KEY `sid_nid` (`sid`,`nid`),
  ADD KEY `data` (`data`(64));

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dfav_authmap`
--
ALTER TABLE `dfav_authmap`
  MODIFY `aid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.';

--
-- AUTO_INCREMENT for table `dfav_block`
--
ALTER TABLE `dfav_block`
  MODIFY `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.', AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT for table `dfav_blocked_ips`
--
ALTER TABLE `dfav_blocked_ips`
  MODIFY `iid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.';

--
-- AUTO_INCREMENT for table `dfav_block_custom`
--
ALTER TABLE `dfav_block_custom`
  MODIFY `bid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The block’s dfav_block.bid.', AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `dfav_clientside_validation_settings`
--
ALTER TABLE `dfav_clientside_validation_settings`
  MODIFY `cvsid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for the clientside validation settings';

--
-- AUTO_INCREMENT for table `dfav_conditional_fields`
--
ALTER TABLE `dfav_conditional_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a dependency.', AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `dfav_date_formats`
--
ALTER TABLE `dfav_date_formats`
  MODIFY `dfid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.', AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `dfav_field_collection_item`
--
ALTER TABLE `dfav_field_collection_item`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique field collection item ID.', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dfav_field_collection_item_revision`
--
ALTER TABLE `dfav_field_collection_item_revision`
  MODIFY `revision_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique revision ID.', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dfav_field_config`
--
ALTER TABLE `dfav_field_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field', AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `dfav_field_config_instance`
--
ALTER TABLE `dfav_field_config_instance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance', AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `dfav_field_group`
--
ALTER TABLE `dfav_field_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a group', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `dfav_file_managed`
--
ALTER TABLE `dfav_file_managed`
  MODIFY `fid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'File ID.', AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `dfav_flood`
--
ALTER TABLE `dfav_flood`
  MODIFY `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.';

--
-- AUTO_INCREMENT for table `dfav_image_effects`
--
ALTER TABLE `dfav_image_effects`
  MODIFY `ieid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dfav_image_styles`
--
ALTER TABLE `dfav_image_styles`
  MODIFY `isid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dfav_locales_source`
--
ALTER TABLE `dfav_locales_source`
  MODIFY `lid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique identifier of this string.', AUTO_INCREMENT=10652;

--
-- AUTO_INCREMENT for table `dfav_menu_links`
--
ALTER TABLE `dfav_menu_links`
  MODIFY `mlid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.', AUTO_INCREMENT=559;

--
-- AUTO_INCREMENT for table `dfav_metatag_config`
--
ALTER TABLE `dfav_metatag_config`
  MODIFY `cid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a metatag configuration set.', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dfav_node`
--
ALTER TABLE `dfav_node`
  MODIFY `nid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.', AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `dfav_node_revision`
--
ALTER TABLE `dfav_node_revision`
  MODIFY `vid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.', AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `dfav_queue`
--
ALTER TABLE `dfav_queue`
  MODIFY `item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.', AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `dfav_role`
--
ALTER TABLE `dfav_role`
  MODIFY `rid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dfav_sequences`
--
ALTER TABLE `dfav_sequences`
  MODIFY `value` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.', AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `dfav_taxonomy_term_data`
--
ALTER TABLE `dfav_taxonomy_term_data`
  MODIFY `tid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.';

--
-- AUTO_INCREMENT for table `dfav_taxonomy_vocabulary`
--
ALTER TABLE `dfav_taxonomy_vocabulary`
  MODIFY `vid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `dfav_url_alias`
--
ALTER TABLE `dfav_url_alias`
  MODIFY `pid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.', AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `dfav_views_view`
--
ALTER TABLE `dfav_views_view`
  MODIFY `vid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The view ID of the field, defined by the database.', AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `dfav_watchdog`
--
ALTER TABLE `dfav_watchdog`
  MODIFY `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.', AUTO_INCREMENT=833;

--
-- AUTO_INCREMENT for table `dfav_webform_submissions`
--
ALTER TABLE `dfav_webform_submissions`
  MODIFY `sid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for this submission.';
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
