<?php 
require_once 'sites/all/libraries/Mobile_Detect/Mobile_Detect.php';
$detect = new Mobile_Detect;
$is_mobile = $detect->isMobile();

$node = menu_get_object(); ?>

<?php if (isset($node) && $node->type == 'videos'): ?>
	<?php $title = $node->title ?>
<?php else: ?>
	<?php global $titleExame ?>
    <?php $title = (isset($titleExame)) ? $titleExame : $row->node_title ?>
<?php endif ?>

<?php 
$image = image_style_url('banner_internas', $row->field_field_image[0]['raw']['uri']);
if ($is_mobile AND !empty($row->field_field_image_mobile[0]['raw']['uri']))
	$image = image_style_url('banner_interna_mobile', $row->field_field_image_mobile[0]['raw']['uri']);

?>
<div class="banner-internas nid-<?php print $row->nid ?>" style="height:250px;background-position: center;background-image: url(<?php print $image ?>)">
    <div class="container">
        <div class="caption text-center">
            <h1><?php print $title ?></h1>
        </div>
    </div>
</div>
