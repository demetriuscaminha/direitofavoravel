<div id="<?php print $block_html_id; ?>" class="<?php print $classes; ?>"<?php print $attributes; ?>>

 	<?php print render($title_prefix); ?>
	<?php if ($block->subject): ?>
	  	<h2<?php print $title_attributes; ?>><?php print $block->subject ?></h2>
	<?php endif;?>
  	<?php print render($title_suffix); ?>

	<div class="content"<?php print $content_attributes; ?>>
		<div class="col-md-3 col-xs-12 left-sidebar">
			<div class="header">
				<div class="title">Equipe Confiável</div>
				<div class="sub-title">Nossos Advogados</div>
			</div>

			<div class="body">
				Eunulla nisiinte aliqua rerit ad teger uada. Nec massacra libero amus cubilia fusce. Eunulla ullam lum tesque mnulla metuscra. Metussed tempusp liquam et lus penatib dictumst egestas elementu
			</div>

			<div class="link">
				<a class="link-lawyer" href="#">CONHEÇA-NOS</a>
			</div>
		</div>

		<div class="col-md-9 col-xs-12">
			<?php echo views_embed_view('advogados', 'block'); ?>
		</div>
	</div>
</div>
