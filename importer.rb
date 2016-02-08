require "jekyll-import";
    JekyllImport::Importers::WordpressDotCom.run({
      "source" => "old.xml",
      "no_fetch_images" => false,
      "assets_folder" => "assets"
    })
