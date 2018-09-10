<div id="<?php print $block_html_id; ?>" class="<?php print $classes; ?>"<?php print $attributes; ?>>

    <?php print render($title_prefix); ?>
    <?php if ($block->subject): ?>
        <h2<?php print $title_attributes; ?>><?php print $block->subject ?></h2>
    <?php endif;?>
    <?php print render($title_suffix); ?>

    <?php $node = menu_get_object() ?>
    <div class="content">
        <div class="link">
            <a href="#" class="btn btn-danger">INSCREVA-SE</a>
        </div>
        <div class="info">
            <div class="title"><h4>Informações</h4></div>
            <div class="info-content">
                <?php if (isset($node->field_date[LANGUAGE_NONE])): ?>
                    <div class="wrap wrap-date">
                        <div class="field-label"><strong>Início das aulas:</strong></div>
                        <div class="date field-content">
                            <?php print format_date($node->field_date[LANGUAGE_NONE][0]['value'], 'custom', 'd/m/Y') ?>
                        </div>
                    </div>
                <?php endif ?>

                <?php if (isset($node->field_days_shifts[LANGUAGE_NONE])): ?>
                    <div class="wrap wrap-days-shifts">
                        <div class="field-label"><strong>Dias/turnos:</strong></div>
                        <div class="days-shifts field-content">
                            <?php print $node->field_days_shifts[LANGUAGE_NONE][0]['value']; ?>
                        </div>
                    </div>
                <?php endif ?>

                <?php if (isset($node->field_workload[LANGUAGE_NONE])): ?>
                    <div class="wrap wrap-workload">
                        <div class="field-label"><strong>Carga horária:</strong></div>
                        <div class="workload field-content">
                            <?php print $node->field_workload[LANGUAGE_NONE][0]['value']; ?>
                        </div>
                    </div>
                <?php endif ?>
            </div>
        </div>

        <?php if (isset($node->field_facilitator_nr[LANGUAGE_NONE][0])): ?>
            <div class="facilitators">
                <div class="title"><h4>Facilitadores</h4></div>

                <?php foreach ($node->field_facilitator_nr[LANGUAGE_NONE] as $item): ?>
                    <?php $item = $item['node']; ?>

                    <div class="facilitator">        
                        <div class="facilitator-content">
                            <?php if (isset($item->field_image[LANGUAGE_NONE][0])): ?>
                                <div class="photo">
                                    <?php $imageUrl = image_style_url('thumbnail', $item->field_image[LANGUAGE_NONE][0]['uri']) ?>
                                    <img src="<?php print $imageUrl ?>" class="img-circle">
                                </div>
                            <?php endif ?>
                            <div class="info">
                                <div class="title"><?php print $item->title ?></div>
                                
                                <?php if (isset($item->body[LANGUAGE_NONE][0])): ?>
                                    <div class="body">
                                        <?php print truncate_utf8($item->body[LANGUAGE_NONE][0]['value'], 100, TRUE, TRUE) ?>
                                    </div>
                                <?php endif ?>
                            </div>
                        </div>
                    </div>
                <?php endforeach ?>
            </div>
        <?php endif ?>
        <?php //kpr($node) ?>
        <?php if (isset($node->field_certification)): ?>
            <div class="certification">
                
            </div>
        <?php endif ?>
    </div>
</div>
