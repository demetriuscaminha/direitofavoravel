<?php $image = (isset($row->field_field_image[0])) ? $row->field_field_image[0]['rendered'] : $row->field_field_youtube[0]['rendered'] ?>
<?php $link = drupal_get_path_alias('node/' . $row->nid); ?>

<div class="youtube-image-thumbnail">
    <?php print drupal_render($image) ?>
    
</div>

<div class="youtube-video hidden">
    <iframe id="youtube-player--<?php print $row->nid ?>" width="560px" height="380px" src="https://www.youtube.com/embed/<?php print $row->field_field_youtube[0]['raw']['video_id'] ?>?rel=0&amp;modestbranding=1&amp;enablejsapi=1&amp;wmode=opaque&amp;controls=0&amp;autohide=1&amp;iv_load_policy=3" frameborder="0" allowfullscreen=""></iframe>
</div>

<div class="caption">
    <div class="youtube-button-play">
        <i class="far fa-play-circle"></i>
    </div>
    <a class="link-content" href="<?php print $link ?>">
        <div class="title"><?php print $row->node_title ?></div>
    </a>

    <?php if (isset($row->field_field_name[0])): ?>
        <div class="lawyer"><?php print $row->field_field_name[0]['raw']['value'] ?></div>
    <?php endif ?>
    <?php if (isset($row->field_body[0])): ?>
        <div class="body"><?php print views_trim_text(array('max_length' => 100, 'ellipsis' => TRUE), $row->field_body[0]['raw']['value']) ?></div>
    <?php endif ?>
</div>