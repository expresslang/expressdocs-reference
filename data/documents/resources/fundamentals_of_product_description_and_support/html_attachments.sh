for f in action_schema application_context_schema approval_schema basic_attribute_schema certification_schema contract_schema date_time_schema document_schema effectivity_schema experience_schema external_reference_schema group_schema language_schema location_schema management_resources_schema measure_schema person_organization_schema product_definition_schema product_property_definition_schema product_property_representation_schema qualifications_schema security_classification_schema support_resource_schema
do
  fname="sections/schemadocs/${f}.adoc"
  cat << EOF > $fname
= X
:lutaml-express-index: schemas; schemas.yaml;
:bare: true
:mn-document-class: iso
:mn-output-extensions: html

[lutaml, schemas, context, leveloffset=+1]
---
{% for schema in context.schemas %}
{% if schema.id == "${f}" %}
{% assign schemaname = schema.id | append: "$" | remove: "_schema$" | remove: "$" | replace: "_", " " | capitalize %}

[%unnumbered]
= {{schemaname }}

[source%unnumbered]
--
{{ schema.source }}
--
{% endif %}
{% endfor %}
---
EOF
done

for f in sections/schemadocs/*.adoc; do
  local="${f##*/}"
  cp $f $local
  echo "compile $f"
  bundle exec metanorma $local
  rm $local
  mv "${local%%.adoc}.html" "sections/schemadocs/${local%%.adoc}.htm"
  mv "${local%%.adoc}.err" sections/schemadocs
  mv "${local%%.adoc}.presentation.xml" sections/schemadocs
done
