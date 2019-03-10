<?php print $output ?>

<div class="hover">
	<?php if (isset($row->field_field_email[0])): ?>
		<div class="email">
			<a href="mailto:<?php print $row->field_field_email[0]['raw']['email'] ?>"> 
				<?php print $row->field_field_email[0]['raw']['email'] ?>
			</a>
		</div>
	<?php endif ?>

	<?php if (isset($row->field_body[0])): ?>
		<?php print $row->field_body[0]['raw']['value'] ?>
	<?php endif ?>

	<div class="social">
		<?php if (isset($row->field_field_link_facebook[0])): ?>
			<div class="facebook">
				<a href="<?php print $row->field_field_link_facebook[0]['raw']['url'] ?>" target="_blank" title="Facebook">
					<i class="fab fa-facebook-f"></i>
				</a>
			</div>
		<?php endif ?>

		<?php if (isset($row->field_field_link_twitter[0])): ?>
			<div class="twitter">
				<a href="<?php print $row->field_field_link_twitter[0]['raw']['url'] ?>" target="_blank" title="Twitter">
					<i class="fab fa-twitter"></i>
				</a>				
			</div>
		<?php endif ?>

		<?php if (isset($row->field_field_link_linkedin[0])): ?>
			<div class="linkedin">
				<a href="<?php print $row->field_field_link_linkedin[0]['raw']['url'] ?>" target="_blank" title="Twitter">
					<i class="fab fa-linkedin-in"></i>
				</a>				
			</div>
		<?php endif ?>

		<?php if (isset($row->field_field_email[0])): ?>
			<div class="email">
				<a href="mailto:<?php print $row->field_field_email[0]['raw']['email'] ?>">
					<i class="fas fa-envelope"></i>
				</a>				
			</div>
		<?php endif ?>
	</div>
</div>