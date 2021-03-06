<?php
require_once 'sites/all/libraries/Mobile_Detect/Mobile_Detect.php';
$detect = new Mobile_Detect;
$is_mobile = $detect->isMobile();

$image = file_create_url($row->field_field_image[0]['raw']['uri']);
?>
<?php if($is_mobile) : $image_mobile = file_create_url($row->field_field_image_mobile[0]['raw']['uri']);?>
	<div class="banner-superbaner-mobile nid-<?php print $row->nid ?>"">
		<a class="css-link-conteudo" href="<?php print $row->field_field_link[0]['raw']['url'] ?>">
			<img class="img-responsive" src="<?php print $image_mobile ?>">
		</a>
	</div>	
<?php else : ?>
<div class="banner-superbaner nid-<?php print $row->nid ?>" style="background-position: center;background-image: url(<?php print $image ?>)">
	<div class="container">
		<div class="content-info">
			<!--<?php if (isset($row->field_field_text_top[0])): ?>
				<div class="text-top">
					<?php print $row->field_field_text_top[0]['raw']['value'] ?>
				</div>
			<?php endif ?>

			<?php if (isset($row->field_field_text_middle[0])): ?>
				<div class="text-middle">
					<?php print $row->field_field_text_middle[0]['raw']['value'] ?>
				</div>
			<?php endif ?>			
			

			<?php if (isset($row->field_field_text_bottom[0])): ?>
				<div class="text-bottom">
					<?php print $row->field_field_text_bottom[0]['raw']['value'] ?>
				</div>
			<?php endif ?>-->			

			<div class="buttons">
				<?php if (isset($row->field_field_link[0])): ?>
					<div class="css-link-<?php print $row->field_field_posicao_link[0]['raw']['value'] ?>">
						<a href="<?php print $row->field_field_link[0]['raw']['url'] ?>" class="btn btn-default" target="_blank">	
							<?php print $row->field_field_link[0]['raw']['title'] ?>
						</a>
					</div>
				<?php endif ?>

				<!--<?php if (isset($row->field_field_link_2[0])): ?>
					<a href="<?php print $row->field_field_link[0]['raw']['url'] ?>" class="btn btn-default" target="_blank">	
						<?php print $row->field_field_link_2[0]['raw']['title'] ?>
					</a>
				<?php endif ?>	-->
			</div>		
		</div>
	</div>

	<!--<div class="banner-bottom">
		<div class="container">
			<div class="col-md-6 col-xs-12 col-1">
				<div class="pull-right">
					<?php if (isset($row->field_field_info_left_title[0])): ?>
						<div class="title-left">
							<?php print $row->field_field_info_left_title[0]['raw']['value'] ?> 
						</div>
					<?php endif ?>

					<?php if (isset($row->field_field_info_left_sub_title[0])): ?>
						<div class="sub-title-left">
							<?php print $row->field_field_info_left_sub_title[0]['raw']['value'] ?> 
						</div>
					<?php endif ?>			
				</div>		
			</div>
			<div class="col-md-6 col-xs-12 col-2">
				<div class="pull-left">
					<?php if (isset($row->field_field_info_right_title[0])): ?>
						<div class="title-left">
							<?php print $row->field_field_info_right_title[0]['raw']['value'] ?> 
						</div>
					<?php endif ?>

					<?php if (isset($row->field_field_info_right_sub_title[0])): ?>
						<div class="sub-title-right">
							<?php print $row->field_field_info_right_sub_title[0]['raw']['value'] ?> 
						</div>
					<?php endif ?>
				</div>
			</div>
		</div>
	</div>-->
</div>
<?php endif; ?>