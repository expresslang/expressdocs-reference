html_attachments.sh
bundle exec metanorma -x xml document.adoc
bundle exec metanorma collection collection.yml -x xml,html,presentation -w iso10303-41
