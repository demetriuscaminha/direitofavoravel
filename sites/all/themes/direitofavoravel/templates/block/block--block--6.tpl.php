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
        <div class="facilitators">
            <div class="title"><h4>Facilitadores</h4></div>
            <div class="facilitators-content"></div>
        </div>

        <?php //kpr($node) ?>
    </div>
</div>
