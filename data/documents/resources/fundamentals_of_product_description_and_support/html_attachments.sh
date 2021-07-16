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
