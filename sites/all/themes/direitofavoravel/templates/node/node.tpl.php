<?php drupal_add_library('system', 'ui.accordion'); ?>
<?php drupal_add_js('
  (function($){
    $(function(){
      $("div[data-accordion]").accordion({heightStyle: "content"});
    });
  })(jQuery)', 'inline') ?>

<article id="node-<?php print $node->nid; ?>" class="<?php print $classes; ?> clearfix"<?php print $attributes; ?>>
  <?php if ((!$page && !empty($title)) || !empty($title_prefix) || !empty($title_suffix) || $display_submitted): ?>
  <header>
    <?php print render($title_prefix); ?>
    <?php if (!$page && !empty($title)): ?>
    <h2<?php print $title_attributes; ?>><a href="<?php print $node_url; ?>"><?php print $title; ?></a></h2>
    <?php endif; ?>
    <?php print render($title_suffix); ?>
    <?php if ($display_submitted): ?>
    <span class="submitted">
      <?php print $user_picture; ?>
      <?php print $submitted; ?>
    </span>
    <?php endif; ?>
  </header>
  <?php endif; ?>
  <?php
    // Hide comments, tags, and links now so that we can render them later.
    hide($content['comments']);
    hide($content['links']);
    hide($content['field_tags']);

    print render($content['field_image']);
    print render($content['body']);
  ?>  
  <?php if (isset($content['field_modules_fc']['#items'][0])): ?>
    <div data-accordion>
      <?php foreach ($content['field_modules_fc']['#items'] as $key => $item): ?>
        <?php $index = sprintf("%02d", $key); ?>
        <?php $field = entity_load('field_collection_item', array($item['value'])); ?>
        <?php $fieldKey = key($field); ?>
        <?php $field = $field[$fieldKey]; ?>

        <div data-control>
          <div class="number"><?php print sprintf("%02d", $index + 1) ?></div>
          <div class="col col-1">
            <div class="title">
              <strong>
                <?php print $field->field_title_custom[LANGUAGE_NONE][0]['value'] ?>    
              </strong>
            </div>

            <?php if (isset($field->field_facilitator_nr[LANGUAGE_NONE][0])): ?>
              <div class="facilitator">
                <?php $fieldFacilitator = node_load($field->field_facilitator_nr[LANGUAGE_NONE][0]['nid']); ?>
                <span>Facilitador: </span>
                <span class="name"><?php print $fieldFacilitator->title ?></span>
              </div>
            <?php endif ?>
          </div>

          <div class="col col-2">
            <?php if (isset($field->field_duration[LANGUAGE_NONE][0])): ?>
              <div class="duration">
                <?php print $field->field_duration[LANGUAGE_NONE][0]['value'] ?>
              </div>
            <?php endif ?>

            <?php if (isset($field->field_area_ref[LANGUAGE_NONE][0])): ?>
              <div class="area">
                <?php $area = taxonomy_term_load($field->field_area_ref[LANGUAGE_NONE][0]['tid']) ?>
                <?php print $area->name  ?>
              </div>
            <?php endif ?>
          </div>
        </div>
        <div data-content>
            <div class="body">
              <?php print $field->field_text_headlight[LANGUAGE_NONE][0]['value'] ?>
            </div>
        </div>
      <?php endforeach ?>
    </div>
  <?php endif ?>

  <?php print render($content['field_investment']); ?>
  <?php
    // Only display the wrapper div if there are tags or links.
    $field_tags = render($content['field_tags']);
    $links = render($content['links']);
    if ($field_tags || $links):
  ?>
   <footer>
     <?php print $field_tags; ?>
     <?php print $links; ?>
  </footer>
    <?php endif; ?>
  <?php print render($content['comments']); ?>
</article>
