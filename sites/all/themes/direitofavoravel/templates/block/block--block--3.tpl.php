<div id="<?php print $block_html_id; ?>" class="<?php print $classes; ?>"<?php print $attributes; ?>>

 	<?php print render($title_prefix); ?>
	<?php if ($block->subject): ?>
	  	<h2<?php print $title_attributes; ?>><?php print $block->subject ?></h2>
	<?php endif;?>
  	<?php print render($title_suffix); ?>

	<div class="content"<?php print $content_attributes; ?>>
		<div class="col-md-3 col-sm-12 left-sidebar">
			<div class="header">
				<div class="title">Equipe Confiável</div>
				<div class="sub-title">Nossos Professores</div>
			</div>

			<div class="body">
			Nosso time é composto de profissionais qualificados, com vivência de mercado, que transmitem com confiança a prática jurídica e os ensinamentos necessários para o crescimento significativo de nossos alunos e ouvintes.

			</div>

			<div class="link">
				<a class="link-lawyer" href="#">CONHEÇA-NOS</a>
			</div>
		</div>

		<div class="col-md-9 col-sm-12">
			<?php echo views_embed_view('advogados', 'block'); ?>
		</div>
	</div>
</div>
