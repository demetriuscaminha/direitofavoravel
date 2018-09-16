<?php $image = image_style_url('banner_internas', $row->field_field_image[0]['raw']['uri']); ?>
<div class="banner-internas nid-<?php print $row->nid ?>" style="height:250px;background-position: center;background-image: url(<?php print $image ?>)">
    <div class="container">
        <div class="caption text-center">
        	<?php global $titleDownloads ?>
        	<?php $title = (isset($titleDownloads)) ? $titleDownloads : $row->node_title ?>
            <h1><?php print $title ?></h1>
        </div>
    </div>
</div>
