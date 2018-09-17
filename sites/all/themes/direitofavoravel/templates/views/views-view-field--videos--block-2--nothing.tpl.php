<?php $image = (isset($row->field_field_image[0])) ? $row->field_field_image[0]['rendered'] : $row->field_field_youtube[0]['rendered'] ?>
<?php $link = drupal_get_path_alias('node/' . $row->nid); ?>

<a class="link-content" href="<?php print $link ?>">
    <div class="youtube-image-thumbnail no-play">
        <?php print drupal_render($image) ?>
        <div class="youtube-button-play">
            <i class="far fa-play-circle"></i>
        </div>
    </div>

    <div class="caption">
        <div class="title"><?php print $row->node_title ?></div>

        <?php if (isset($row->field_field_name[0])): ?>
            <div class="lawyer"><?php print $row->field_field_name[0]['raw']['value'] ?></div>
        <?php endif ?>
        <?php if (isset($row->field_body[0])): ?>
            <div class="body"><?php print views_trim_text(array('max_length' => 100, 'ellipsis' => TRUE), $row->field_body[0]['raw']['value']) ?></div>
        <?php endif ?>
    </div>
</a>