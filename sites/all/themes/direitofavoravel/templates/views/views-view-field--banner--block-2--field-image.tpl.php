<?php $node = menu_get_object() ?>
<?php global $cursoPresencialNid ?>
<?php global $cursoPresencialBanner ?>

<?php if (!empty($node)): ?>
	<!-- para página interna do conteúdo -->
	<?php $image = image_style_url('banner_internas', $row->field_field_image[0]['raw']['uri']); ?>
	<div class="banner-internas nid-<?php print $row->nid ?>" style="height:250px;background-position: center;background-image: url(<?php print $image ?>)">
	    <div class="container">
	        <div class="caption text-center">
	        	<?php if (isset($node->field_area_ref[LANGUAGE_NONE][0])): ?>
	        		<?php $area = taxonomy_term_load($node->field_area_ref[LANGUAGE_NONE][0]['tid']) ?>
	        		<div class="area"><?php print $area->name ?></div>
	        	<?php endif ?>
	            <div class="title"><?php print $node->title ?></div>
	            <?php if (isset($node->field_title_custom[LANGUAGE_NONE][0])): ?>
	            	<div class="sub-title">
	            		<?php print $node->field_title_custom[LANGUAGE_NONE][0]['value'] ?>		
	            	</div>
	            <?php endif ?>
	        </div>
	    </div>
	</div>
<?php elseif (!empty($cursoPresencialNid && $cursoPresencialBanner)): ?>
	<!-- para listagem com ultimo conteúdo -->
	<?php $node = node_load($cursoPresencialNid) ?>
	<?php $image = image_style_url('banner_internas', $cursoPresencialBanner); ?>
	<div class="banner-internas nid-<?php print $row->nid ?>" style="height:250px;background-position: center;background-image: url(<?php print $image ?>)">
	    <div class="container">
	        <div class="caption text-center">
	        	<?php if (isset($node->field_area_ref[LANGUAGE_NONE][0])): ?>
	        		<?php $area = taxonomy_term_load($node->field_area_ref[LANGUAGE_NONE][0]['tid']) ?>
	        		<div class="area"><?php print $area->name ?></div>
	        	<?php endif ?>
	            <div class="title"><?php print $node->title ?></div>
	            <?php if (isset($node->field_title_custom[LANGUAGE_NONE][0])): ?>
	            	<div class="sub-title">
	            		<?php print $node->field_title_custom[LANGUAGE_NONE][0]['value'] ?>		
	            	</div>
	            <?php endif ?>
	        </div>
	    </div>
	</div>
<?php endif ?>
