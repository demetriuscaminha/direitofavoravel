<div id="node-<?php print $node->nid; ?>" class="<?php print $classes; ?> clearfix"<?php print $attributes; ?>>

  <?php print $user_picture; ?>

  <?php print render($title_prefix); ?>
  <?php if (!$page): ?>
    <h2<?php print $title_attributes; ?>><a href="<?php print $node_url; ?>"><?php print $title; ?></a></h2>
  <?php endif; ?>
  <?php print render($title_suffix); ?>

  <?php if ($display_submitted): ?>
    <div class="submitted">
      <?php print $submitted; ?>
    </div>
  <?php endif; ?>

  <div class="content"<?php print $content_attributes; ?>>
    <?php
      // We hide the comments and links now so that we can render them later.
      hide($content['comments']);
      hide($content['links']);
    ?>
	<div class="wrap-video">
		<div class="youtube-image-thumbnail">
		    <?php $image = ($content['field_image']) ? $content['field_image']: $content['field_youtube'] ?>
        <?php print render($image) ?>
		    <div class="youtube-button-play">
		        <i class="far fa-play-circle"></i>
		    </div>
		</div>

	    <div class="youtube-video hidden">
	    	<iframe id="youtube-player" width="100%" height="480px" src="https://www.youtube.com/embed/<?php print $content['field_youtube']['#items'][0]['video_id'] ?>?rel=0&amp;modestbranding=1&amp;enablejsapi=1&amp;wmode=opaque&amp;controls=0&amp;autohide=1&amp;iv_load_policy=3" frameborder="0" allowfullscreen=""></iframe>
		</div>

		<div class="caption video-caption">
		    <div class="title"><?php print $node->title ?></div>
		    
		    <?php if (isset($node->field_name[LANGUAGE_NONE][0])): ?>
		        <div class="lawyer"><?php print $node->field_name[LANGUAGE_NONE][0]['value'] ?></div>
		    <?php endif ?>
		</div>	
	</div>
	<?php print drupal_render($content['body']) ?>
  </div>

  <?php print render($content['links']); ?>

  <?php print render($content['comments']); ?>

</div>
