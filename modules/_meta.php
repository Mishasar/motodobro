<?

session_start();

$data = $_SERVER['REQUEST_URI'];

switch($data){

 case '/' : 
  $T = 'Мотозапчасти с доставкой | Купить по выгодным ценам';
  $D = 'Интернет-магазин запчастей от дилеров для мотоциклов и скутеров. Наш сайт осуществляет онлайн продажу оригинальных комплектующих для мототехники на заказ с доставкой по разумной стоимости. Каталог. Оптом и в розницу.';
  $K = 'интернет магазин мотозапчастей, в москве, купить, мототехника, запчасти';
  $H = 'Интернет магазин мотозапчастей';
  $h2 = '«Motodobro.ru» магазин мотозапчастей в Москве';
 break;

 case '/deliv.html' :
  $T = 'Варианты доставки товара';
  $K = 'запчасти для мотоциклов, квадроциклов, запчасти для гидроциклов, снегоходов, катеров';
  $D = 'Запчасти для мотоциклов и квадроциклов.';
  break;

   case '/1_31_zapchasti_dlya_motociklov_Victory_(Polaris).html' :
  $T = 'Запчасти для мотоциклов Victory (Polaris) | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для мотоциклов Victory (Polaris) оптом и в розницу с доставкой. Каталог оригинальных запчастей для мотоциклов Victory (Polaris) с выбором года выпуска.  Выгодные цены и высокое качество.';
  break;

 case '/0_2_Originalnye_zapchasti_dlya_kvadrociklov_ATV.html' : 
  $T = 'Запчасти для квадроциклов ATV | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей оптом и в розницу с доставкой. Каталог оригинальных запчастей для квадроциклов ATV Arctic Cat, Can-Am (Bombardier), Honda, Kawasaki, KTM, Polaris, Suzuki, Yamaha. Разумная стоимость.';
  $H = 'Запчасти для квадроциклов ATV';
 break;
  
 case '/0_7_Originalnye_zapchasti_dlya_motovezdehodov_UTV.html' : 
  $T = 'Запчасти для мотовездеходов UTV | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей оптом и в розницу с доставкой. Каталог оригинальных запчастей для мотовездеходов UTV Arctic Cat, Can-Am (Bombardier), Honda, Kawasaki, Polaris Ranger, Polaris RZR, Suzuki, Yamaha. Разумная стоимость.';
  $H = 'Запчасти для мотовездеходов UTV';
 break;
 
 case '/0_5_Originalnye_zapchasti_dlya_katerov.html' : 
  $T = 'Запчасти для катеров | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей оптом и в розницу с доставкой. Каталог оригинальных запчастей для катеров Sea-Doo (Bombardier), Yamaha. Разумная стоимость.';
  $H = 'Запчасти для катеров';
 break;
  
 case '/1_75_Originalnye_zapchasti_dlya_motociklov_Harley_Davidson.html' : 
  $T = 'Запчасти для мотоциклов Harley Davidson | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для мотоциклов Harley Davidson оптом и в розницу по выгодным ценам с доставкой. Каталог оригинальных запчастей для мотоциклов Харлей Дэвидсон с выбором года выпуска. Высокое качество.';
  $H = 'Запчасти для мотоциклов Harley Davidson';
 break; 
 
 case '/1_21_Originalnye_zapchasti_dlya_kvadrociklov_ATV_KTM.html' : 
  $T = 'Запчасти для квадроциклов ATV KTM | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей для квадроциклов ATV KTM оптом и в розницу с доставкой. Каталог оригинальных запчастей для квадроциклов ATV KTM с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для квадроциклов ATV KTM';
 break;
 
 case '/1_68_Originalnye_zapchasti_dlya_motociklov_Slingshot.html' : 
  $T = 'Запчасти для мотоциклов Slingshot | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей для мотоциклов Slingshot оптом и в розницу с доставкой. Каталог оригинальных запчастей для мотоциклов Slingshot с выбором года выпуска.  Разумная стоимость и высокое качество.';
  $H = 'Запчасти для мотоциклов Slingshot';
 break;
 
 case '/1_32_Originalnye_zapchasti_dlya_motociklov_Suzuki.html' : 
  $T = 'Запчасти для мотоциклов Suzuki | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей для мотоциклов Suzuki оптом и в розницу с доставкой. Каталог оригинальных запчастей для мотоциклов Сузуки с выбором года выпуска.  Разумная стоимость и высокое качество.';
  $H = 'Запчасти для мотоциклов Suzuki';
 break;
 
 case '/1_52_Originalnye_zapchasti_dlya_motociklov_Triumph.html' : 
  $T = 'Запчасти для мотоциклов Triumph | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей для мотоциклов Triumph оптом и в розницу с доставкой. Каталог оригинальных запчастей для мотоциклов Триумф с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для мотоциклов Triumph';
 break;
 
 case '/1_59_Originalnye_zapchasti_dlya_motociklov_Indian.html' : 
  $T = 'Запчасти для мотоциклов Indian | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей для мотоциклов Indian оптом и в розницу с доставкой. Каталог оригинальных запчастей для мотоциклов Индиан с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для мотоциклов Indian';
 break;
 
 case '/1_17_Originalnye_zapchasti_dlya_kvadrociklov_ATV_Can-Am_(Bombardier).html' : 
  $T = 'Запчасти для квадроциклов Can-Am (Bombardier) | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для квадроциклов ATV Can-Am (Bombardier) оптом и в розницу с доставкой. Каталог оригинальных запчастей с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для квадроциклов Can-Am (Bombardier)';
 break;
 
 case '/1_19_Originalnye_zapchasti_dlya_kvadrociklov_ATV_Kawasaki.html' : 
  $T = 'Запчасти для квадроциклов ATV Kawasaki | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для квадроциклов ATV Kawasaki оптом и в розницу с доставкой. Каталог оригинальных запчастей для квадроциклов Кавасаки с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для квадроциклов ATV Kawasaki';
 break;
 
 case '/1_69_Originalnye_zapchasti_dlya_motovezdehodov_UTV_Polaris_RZR.html' : 
  $T = 'Запчасти для мотовездеходов UTV Polaris RZR | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для мотовездеходов UTV Polaris RZR оптом и в розницу с доставкой. Каталог оригинальных запчастей с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для мотовездеходов UTV Polaris RZR';
 break;
 
 case '/1_39_Originalnye_zapchasti_dlya_gidrociklov_Honda.html' : 
  $T = 'Запчасти для гидроциклов Honda | Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для гидроциклов Honda оптом и в розницу с доставкой. Каталог оригинальных запчастей для гидроциклов Хонда с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для гидроциклов Honda';
 break;
 
 case '/1_7_Originalnye_zapchasti_dlya_gidrociklov_Yamaha.html' : 
  $T = 'Запчасти для гидроциклов Yamaha | Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для гидроциклов Yamaha оптом и в розницу с доставкой. Каталог оригинальных запчастей для гидроциклов Ямаха с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для гидроциклов Yamaha';
 break;
  
 case '/1_43_Originalnye_zapchasti_dlya_lodochnyh_motorov_Mariner.html' : 
  $T = 'Запчасти на лодочные моторы Mariner|Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для лодочных моторов Mariner оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Mariner с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для лодочных моторов Mariner';
 break; 
 
 case '/1_66_Originalnye_zapchasti_dlya_lodochnyh_motorov_Mercruiser__Sterndrives.html' : 
  $T = 'Запчасти для лодочных моторов Mercruiser Sterndrives | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для лодочных моторов Mercruiser Sterndrives оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Mercruiser Sterndrives с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для лодочных моторов Mercruiser Sterndrives';
 break;
  
 case '/1_44_Originalnye_zapchasti_dlya_lodochnyh_motorov_Mercury.html' : 
  $T = 'Запчасти на лодочные моторы Mercury|Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для подвесных лодочных моторов Mercury оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Mercury с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для лодочных моторов Mercury';
 break; 
  
 case '/view_cat.htm?id=11' : 
  $T = 'Мотозапчасти с доставкой | Купить по выгодным ценам';
  $D = 'Интернет-магазин запчастей от дилеров для мотоциклов и скутеров. Наш сайт осуществляет онлайн продажу оригинальных комплектующих для мототехники на заказ с доставкой по разумной стоимости. Каталог. Оптом и в розницу.';
  $K = 'интернет магазин мотозапчастей, в москве, купить, мототехника, запчасти';
  $H = 'Интернет магазин мотозапчастей';
 break;
 
 case '/1_28_Zapchasti_dlya_skuterov_Suzuki.html' : 
  $T = 'Запчасти для скутеров Suzuki | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей для японских скутеров Suzuki оптом и в розницу с доставкой. Каталог оригинальных запчастей для скутеров Сузуки с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для скутеров Suzuki';
 break;
 
 case '/1_29_Zapchasti_dlya_skuterov_Yamaha.html' : 
  $T = 'Запчасти для скутеров Yamaha | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей для японских скутеров Yamaha оптом и в розницу с доставкой. Каталог оригинальных запчастей для скутеров Ямаха с выбором года выпуска.  Разумная стоимость и высокое качество.';
  $H = 'Запчасти для скутеров Yamaha';
 break;
 
 case '/1_5_Zapchasti_dlya_kvadrociklov_ATV_Suzuki.html' : 
  $T = 'Запчасти для квадроциклов ATV Suzuki | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для квадроциклов ATV Suzuki оптом и в розницу с доставкой. Каталог оригинальных запчастей для квадроциклов Сузуки с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для квадроциклов ATV Suzuki';
 break;
 
 case '/1_6_Zapchasti_dlya_kvadrociklov_ATV_Yamaha.html' :
  $T = 'Запчасти для квадроциклов ATV Yamaha | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для квадроциклов ATV Yamaha оптом и в розницу с доставкой. Каталог оригинальных запчастей для квадроциклов Ямаха с выбором года выпуска. Выгодные цены и высокое качество.'; 
  $H = 'Запчасти для квадроциклов ATV Yamaha';
 break;
 
 case '/1_18_Zapchasti_dlya_kvadrociklov_ATV_Honda.html' :
  $T = 'Запчасти для квадроциклов ATV Honda | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для квадроциклов ATV Honda оптом и в розницу с доставкой. Каталог оригинальных запчастей для квадроциклов Хонда с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для квадроциклов ATV Honda';
 break;
 
 case '/1_20_Zapchasti_dlya_kvadrociklov_ATV_Arctic_Cat.html' : 
  $T = 'Запчасти для квадроциклов Arctic Cat | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для квадроциклов ATV Arctic Cat оптом и в розницу с доставкой. Каталог оригинальных запчастей для квадроциклов Арктик Кэт с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для квадроциклов ATV Arctic Cat';
 break;
 
 case '/1_21_Zapchasti_dlya_kvadrociklov_ATV_KTM.html' : 
  $T = 'Запчасти для квадроциклов KTM | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей для квадроциклов ATV KTM оптом и в розницу с доставкой. Каталог оригинальных запчастей для квадроциклов ATV KTM с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для квадроциклов ATV KTM';
 break;
 
 case '/1_22_Zapchasti_dlya_motovezdehodov_UTV_Kawasaki.html' : 
  $H = 'Запчасти для мотовездеходов UTV Kawasaki';
 break;
 
 case '/1_25_Zapchasti_dlya_motovezdehodov_UTV_Yamaha.html' : 
  $H = 'Запчасти для мотовездеходов UTV Yamaha';
 break;
 
 case '/1_60_Zapchasti_dlya_motovezdehodov_UTV_Arctic_Cat.html' : 
  $H = 'Запчасти для мотовездеходов UTV Arctic Cat';
 break;
 
 case '/1_61_Zapchasti_dlya_motovezdehodov_UTV_Honda.html' : 
  $H = 'Запчасти для мотовездеходов UTV Honda';
 break;
 
 case '/1_62_Zapchasti_dlya_motovezdehodov_UTV_Can-Am_%28Bombardier%29.html' : 
  $H = 'Запчасти для мотовездеходов UTV Can-Am (Bombaddrdier)';
 break;
 
 case '/1_8_Zapchasti_dlya_snegohodov_v_Moskve_Yamaha.html' :
  $T = 'Запчасти для снегоходов Yamaha | Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для снегоходов Yamaha оптом и в розницу с доставкой. Каталог оригинальных запчастей для снегоходов Ямаха с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для снегоходов Yamaha';
 break;
 
 case '/1_13_Zapchasti_dlya_snegohodov_v_Moskve_Arctic_Cat.html' : 
  $T = 'Запчасти на снегоходы Arctic Cat | Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для снегоходов Arctic Cat оптом и в розницу с доставкой. Каталог оригинальных запчастей для снегоходов Арктик Кэт с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для снегоходов Arctic Cat';
 break;
 
 case '/1_26_Zapchasti_dlya_snegohodov_v_Moskve_Ski-Doo_%28Bombardier%29.html' : 
  $T = 'Запчасти для снегоходов Ski-Doo (Bombardier) | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для снегоходов Ski-Doo (Bombardier) оптом и в розницу с доставкой. Каталог оригинальных запчастей для снегоходов Скидо (Бомбардир) с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для снегоходов Ski-Doo (Bombardier)';
 break;
 
 case '/1_42_Zapchasti_dlya_gidrociklov_Sea-Doo_%28Bombardier%29.html' :
  $T = 'Запчасти для гидроциклов Sea-Doo (Bombardier) | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для гидроциклов Sea-Doo (Bombardier) оптом и в розницу с доставкой. Каталог оригинальных запчастей для гидроциклов Сиаду с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для гидроциклов Sea-Doo (Bombardier)';
 break;
 
 
 case '/1_45_Zapchasti_dlya_katerov_Sea-Doo_%28Bombardier%29.html' :
  $T = 'Запчасти для катеров Sea-Doo (Bombardier) | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для катеров Sea-Doo (Bombardier) оптом и в розницу с доставкой. Каталог оригинальных запчастей для катеров Сиаду (Бомбардир) с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для катеров Sea-Doo (Bombardier)';
 break;
 
 case '/1_11_Katalog_zapchastej_dlya_lodochnyh_motorov_Johnson.html' :
  $T = 'Запчасти для лодочных моторов Johnson | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для лодочных моторов Johnson оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Johnson с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для лодочных моторов Johnson';
 break;
 
  case '/1_36_Katalog_zapchastej_dlya_lodochnyh_motorov_Suzuki_Marine.html' : 
  $T = 'Запчасти для лодочных моторов Suzuki Marine | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для лодочных моторов Suzuki Marine оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Сузуки с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для лодочных моторов Suzuki Marine';
 break;
 
 case '/1_37_Katalog_zapchastej_dlya_lodochnyh_motorov_Evinrude.html' : 
  $T = 'Запчасти для лодочных моторов Evinrude | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для лодочных моторов Evinrude оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Evinrude с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для лодочных моторов Evinrude';
 break;
 
 case '/1_49_Katalog_zapchastej_dlya_lodochnyh_motorov_Honda_Marine.html' :
  $T = 'Запчасти для лодочных моторов Honda Marine | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для лодочных моторов Honda Marine оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Хонда с выбором года выпуска. Выгодные цены и высокое качество.';
  $H = 'Запчасти для лодочных моторов Honda Marine';
 break;
 
 case '/1_50_Katalog_zapchastej_dlya_lodochnyh_motorov_Force.html' : 
  $T = 'Запчасти на лодочные моторы Force |Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для лодочных моторов Force оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Force с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для лодочных моторов Force';
 break;
 
 case '/1_57_Katalog_zapchastej_dlya_lodochnyh_motorov_Nissan.html' : 
  $T = 'Запчасти на лодочные моторы Nissan|Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для лодочных моторов Nissan оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Ниссан с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для лодочных моторов Nissan';
 break;
 
 case '/1_55_Katalog_zapchastej_dlya_lodochnyh_motorov_Yamaha.html' : 
  $T = 'Запчасти на лодочные моторы Yamaha|Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для лодочных моторов Yamaha оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Ямаха с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для лодочных моторов Yamaha';
 break;
 
 case '/1_56_Katalog_zapchastej_dlya_lodochnyh_motorov_Tohatsu.html ' : 
  $T = 'Запчасти на лодочные моторы Tohatsu|Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для лодочных моторов Tohatsu оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Tohatsu с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для лодочных моторов Tohatsu';
 break;


  case '/1_26_Zapchasti_dlya_snegohodov_Ski-Doo_%28Bombardier%29.html' : 
  $T = 'Запчасти для снегоходов Ski Doo в Москве ';
  $D = 'Запчасти для снегоходов в Москве Ski-Doo (Bombardier) ';
  $K = 'Запчасти для снегоходов Ski-Doo ';
  $H = 'Запчасти для снегоходов Ski Doo';
  break;
 
 case '/cModelParts_289227.html' : 
  $T = 'Цепь для мотоцикла купить';
  $D = 'Цепь для мотоцикла SUZUKI и другие виды мотозапчастей  в интернет магазине «MOTODOBRO»';
  $K = 'цепь для мотоцикла';
  $H = 'Цепь для мотоцикла ГРМ';
 break;

 case '/cModelUnits_4959.html' : 
  $T = 'Запчасти для снегохода Ямаха викинг 540';
  $D = 'У нас вы можете купить Запчасти для снегохода Ямаха викинг 540 по выгодным ценам.';
  $K = 'запчасти для снегохода ямаха викинг 540';
  $H = 'Запчасти снегоход Ямаха викинг 540';
  $h2 = 'Каталог запчастей для снегохода Ямаха Викинг';
 break;

 case '/1_27_Zapchasti_dlya_skuterov_Honda.html' : 
  $T = 'Запчасти для скутеров Honda | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей для японских скутеров honda оптом и в розницу с доставкой. Каталог оригинальных запчастей для скутеров Хонда с выбором года выпуска. Разумная стоимость и высокое качество.';
  $K = 'запчасти на скутер Хонда';
  $H = 'Запчасти для скутеров Honda';
  //$h2 = 'Запчасти для снегоходов в Москве Yamaha';
 break;

 case '/1_8_Zapchasti_dlya_snegohodov_Yamaha.html' : 
  $T = 'Запчасти для снегоходов Yamaha | Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для снегоходов Yamaha оптом и в розницу с доставкой. Каталог оригинальных запчастей для снегоходов Ямаха с выбором года выпуска. Разумная стоимость и высокое качество. ';
  $K = 'Запчасти для снегоходов Yamaha Ямаха';
  $H = 'Запчасти для снегоходов Ямаха';
 break;
  
 case '/0_1_Zapchasti_dlya_motociklov.html' : 
  $T = 'Запчасти для мотоциклов | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей оптом и в розницу с доставкой. Каталог оригинальных запчастей для мотоциклов BMW Motosport, Can-Am, Harley Davidson, Honda, Indian, Kawasaki, KTM, Slingshot, Suzuki, Victory, Yamaha. Разумная стоимость.';
  $K = 'запчасти для мотоциклов в москве, магазин запчастей мотоциклов,купить запчасти для мотоцикла, запчасти для мотоциклов интернет магазин';
  //$H = 'Запчасти для мотоциклов интернет магазин';  
 break; 
 
  case '/0_3_Zapchasti_dlya_gidrociklov.html' : 
  $T = 'Запчасти для гидроциклов | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей оптом и в розницу с доставкой. Каталог оригинальных запчастей для гидроциклов Honda, Kawasaki, Polaris, Sea-Doo (Bombardier), Yamaha. Разумная стоимость.';
  $K = 'запчасти для гидроциклов';
  
 break;
 
  case '/0_4_Zapchasti_dlya_snegohodov.html' : 
  $T = 'Запчасти для снегоходов | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей оптом и в розницу с доставкой. Каталог оригинальных запчастей для снегоходов Arctic Cat, Polaris, Ski-Doo (Bombardier), Yamaha. Разумная стоимость.';
  $K = 'запчасти для снегоходов в москве, магазин';
 break;
 
  case '/0_8_Zapchasti_dlya_skuterov.html' : 
  $T = 'Запчасти для скутеров | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей оптом и в розницу с доставкой. Каталог оригинальных запчастей для скутеров BMW Motosport, Can-Am, Harley Davidson, Honda, Indian, Kawasaki, KTM, Slingshot, Suzuki, Victory, Yamaha. Разумная стоимость. ';
  $K = 'запчасти для скутеров интернет магазин, купить, в москве';
 break;
 
 
 case '/1_3_Zapchasti_dlya_motociklov_Yamaha.html' : 
  $T = 'Запчасти для мотоциклов Yamaha | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей для кроссовых мотоциклов Yamaha оптом и в розницу с доставкой. Каталог оригинальных запчастей для мотоциклов Ямаха с выбором года выпуска. Разумная стоимость и высокое качество.';
  $K = 'Запчасти для мотоцикла ямаха';
  //$H = 'Запчасти для мотоцикла Ямаха (Yamaha)';
 break;
 
 case '/1_35_Zapchasti_dlya_motociklov_Honda.html' : 
  $T = 'Запчасти для мотоциклов Honda | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей для мотоциклов Honda оптом и в розницу с доставкой. Каталог оригинальных запчастей для мотоциклов Хонда с выбором года выпуска. Разумная стоимость и высокое качество.';
  $K = 'запчасти для мотоциклов honda, хонда мотозапчасти';
  //$H = 'Запчасти для мотоциклов Honda (Хонда)';
 break;

 case '/1_51_Zapchasti_dlya_motociklov_BMW.html' : 
  $T = 'Запчасти для мотоциклов BMW в Москве';
  $D = 'У нас Вы можете купить запчасти для мотоциклов bmw по выгодным ценам.';
  $K = 'запчасти для мотоциклов bmw';
 break;

  case '/1_30_zapchasti_dlya_motociklov_Can-Am_(Bombardier).html' : 
  $T = 'Запчасти для мотоциклов Can-Am (Bombardier) | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для мотоциклов Can-Am (Bombardier) оптом и в розницу по выгодным ценам с доставкой. Каталог оригинальных запчастей от дилеров с выбором года выпуска. Высокое качество.';
 break;
 
   case '/cModelParts_665917.html' : 
  $T = 'запчасти для катеров Sea-Doo ';
  $D = 'Запчасти для катеров Sea-Doo (Bombardier) Sportster 4-TEC SCIC, Edition 2 Система охлаждения ';
  $K = 'запчасти для катеров ';
  $H = 'Запчасти для катеров: Система охлаждения';
  $S = '<p>На данной странице вы можете ознакомиться с предлагаемыми нашей компанией запчастями для катеров «Sea-Doo Bombardier Sportster» модели 4-TEC SCIC (Edition 2). В ассортименте под заказ представлены основные элементы, входящие в систему охлаждения данного транспортного средства, а также другие детали. Наша компания поставляет только оригинальную продукцию непосредственно от производителя, включая аксессуары и дополнительное оборудование. Каждая деталь – в заводской упаковке.</p>
<p>Если вам нужны качественные запчасти для катеров, а также уверенность в том, что приобретенные изделия надежны и не являются подделкой, обращайтесь к нам! </p>
<p>Мы обеспечиваем поставку в короткие сроки по минимальным расценкам. Обратите внимание, что не все детали, имеющиеся в каталоге, есть на нашем складе. Этот вопрос решается в индивидуальном порядке, мы готовы быстро заказать требуемую запчасть непосредственно с завода производителя и оперативно доставить её вам!</p>
<p>Если вас интересует другая модель или конкретная деталь, не представленная в списке, воспользуйтесь удобным поиском, расположенным вверху страницы.</p>
<p>Заказывайте запчасти для катеров «Sea-Doo Bombardier Sportster» модели 4-TEC SCIC (Edition 2) у нас, и вы получите качественный сервис и максимальную оперативность! По всем вопросам, касающимся наличия деталей на складе, оформления заказа и цен, обращайтесь в нашу службу поддержки по номеру:</p>
<p>8-(499)-703-0276.</p>
<p>Опытные специалисты, сидящие на линии, подробно проконсультируют вас и помогут сориентироваться в ассортименте.</p>';
 break;
 
   case '/1_36_Zapchasti_dlya_lodochnyh_motorov_Suzuki_Marine.html' : 
  $T = 'Запчасти для лодочных моторов Suzuki Marine | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для лодочных моторов Suzuki Marine оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Сузуки с выбором года выпуска. Выгодные цены и высокое качество.';
  $K = 'Запчасти для лодочных моторов Сузуки ';
  $H = 'Запчасти для лодочных моторов Сузуки';
  break;
 
   case '/cModelParts_98410.html' : 
  $T = 'Запчасти для квадроциклов Ямаха ATV Yamaha Grizzly ';
  $D = 'Запчасти для квадроциклов ATV Yamaha Grizzly 660 Фара головного света ';
  $K = 'запчасти для квадроциклов ямаха ';
  $H = 'запчасти для квадроциклов Ямаха: Фара головного света';
  $S = '<p>Квадроцикл – очень мощный вид транспорта, используемый не только в экстремальном спорте, но и в хозяйстве, в охоте и рыбалке. И в последнее время они набирают всё большую популярность. Квадроциклы от компании «Ямаха» отличает возможность проехать практически везде, в том числе по пересеченной местности. Маневренные и удобные в управлении, эти транспортные средства обладают выдающимися ходовыми качествами.</p>
<p>Однако рано или поздно любую технику приходится чинить. Это может случиться по причине ДТП или слишком интенсивной эксплуатации. Так или иначе, любая деталь с любым запасом прочности всё равно может износиться до такой степени, что её нельзя будет использовать.</p>
<p>Мы рекомендуем приобретать только оригинальные запчасти для квадроциклов «Ямаха»!</p>
<p>Это гарантирует покупку надежных деталей, качество которых заявляет сам производитель. В нашем ассортименте вы найдете большой выбор изделий, которые можно заказать напрямую от официальных поставщиков.</p>
<p>Обратите внимание, что на складе есть не все запчасти для квадроциклов «Ямаха», представленные в каталоге. Этот вопрос всегда решается индивидуально! Мы обеспечим оперативную доставку заказных изделий – можете не беспокоиться!</p>
<p>По всем вопросам, касающимся наличия запчастей для квадроциклов «Ямаха» на складе, оформления заказа и цен, обращайтесь в нашу службу поддержки по номеру:</p>
<p>8-(499)-703-0276.</p>
<p>Опытные специалисты, сидящие на линии, подробно проконсультируют вас и помогут сориентироваться в ассортименте.</p>';
  break;
 
  case '/1_12_Zapchasti_dlya_kvadrociklov_ATV_Polaris.html' : 
  $T = 'Запчасти для квадроциклов ATV Polaris | Купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для квадроциклов ATV Polaris оптом и в розницу с доставкой. Каталог оригинальных запчастей для квадроциклов Поларис с выбором года выпуска. Выгодные цены и высокое качество.';
  $K = 'запчасти для квадроцикла поларис Polaris ';
  $H = 'Запчасти для квадроциклов  Поларис ATV Polaris';
  break;

  case '/1_14_Zapchasti_dlya_snegohodov_v_Moskve_Polaris.html' : 
  $T = 'Запчасти для снегоходов Polaris | Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для снегоходов Polaris оптом и в розницу с доставкой. Каталог оригинальных запчастей для снегоходов Поларис с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти для снегоходов Полярис Polaris ';
  break;
 
 case '/0_6_Zapchasti_dlya_lodochnyh_motorov.html' : 
  $T = 'Запчасти для лодочных моторов | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей оптом и в розницу с доставкой. Каталог оригинальных запчастей для лодочных моторов Evinrude, Force, Honda Marine, Johnson, Mariner, Mercruiser Sterndrives, Mercury, Nissan, Suzuki Marine, Tohatsu, Yamaha. ';
  $K = 'Купить запчасти для лодочных моторов ';
  $H = 'Запчасти для лодочных моторов';
  break;
 
  case '/1_34_Zapchasti_dlya_motociklov_Kawasaki.html' : 
  $T = 'Запчасти для мотоциклов Kawasaki | Купить по выгодным ценам';
  $D = 'Интернет-магазин осуществляет продажу запчастей для мотоциклов Kawasaki оптом и в розницу с доставкой. Каталог оригинальных запчастей для мотоциклов Кавасаки с выбором года выпуска. Разумная стоимость и высокое качество.';
  $K = 'Запчасти для мотоциклов Kawasaki Каваски ';
  $H = 'Запчасти для мотоциклов Kawasaki';
  break;

 

   case '/1_33_Internet_magazin_zapchasti_dlya_motociklov_KTM.html' : 
  $T = 'Запчасти для мотоциклов KTM в интернет магазине. ';
  $D = 'В нашем интернет магазине Вы можете купить качественные запчасти для мотоциклов KTM по низким ценам. ';
  break;
 
 
  case '/2_930_Zapchasti_dlya_motociklov_KTM_2013.html' : 
  $T = 'Запчасти для мотоцикла КТМ 2013 в Москве ';
  $D = 'У нас вы можете купить запчасти для мотоциклов KTM 2013 ';
  $K = 'Запчасти для мотоцикла КТМ ';
  $H = 'Запчасти для мотоцикла КТМ 2013';
  $S = '<p>На данной странице представлен выбор моделей мотоциклов «КТМ». Указав интересующую модель, вы попадете на соответствующую страницу, где сможете ознакомиться со списком доступных запчастей. Их можно приобрести в нашей компании по хорошей стоимости!</p>
<p>Хотим обратить ваше внимание на тот факт, что наша фирма работает только с оригинальными запчастями. Мы считаем, что если вы хотите быть уверенным в надежности своего транспортного средства, лучше всего устанавливать запчасти для мотоцикла «КТМ» непосредственно от производителя! </p>
<p>Наша фирма работает с проверенными поставщиками, а потому качество мы можем гарантировать!</p>
<p>В ассортименте представлены все необходимые детали для ремонта транспортных средств этой марки. Однако обратите внимание, что не все запчасти для мотоцикла «КТМ» имеются на складе! Дело в том, что информация на странице представлена больше для ознакомления. Вы можете сделать заказ любой детали, но в некоторых случаях придется подождать доставки продукта с завода изготовителя. </p>
<p>Мы заботимся о качестве своих услуг и высоком уровне сервиса, а потому оперативность и профессионализм гарантируем! </p>
<p>По всем вопросам, касающимся наличия запчастей для мотоцикла «КТМ» на складе, оформления заказа и цен, обращайтесь в нашу службу поддержки по номеру:</p>
<p>8-(499)-703-0276.</p>
<p>Опытные специалисты, сидящие на линии, подробно проконсультируют вас и помогут сориентироваться в ассортименте. </p>';
  break;
  
  case '/cModelParts_217939.html' : 
  $S = '<p>Снегоходы от японского концерна Yamaha считают одними из  лучших в мире. Такая техника может с успехом применяться как для обычного  перемещения по зимним трассам в качестве практичного транспорта, так и для  охоты, сезонной рыбалки, спортивных соревнований и других экстремальных видов  развлечений. </p>
<p>  Все снегоходы данного бренда популярны по причине своей надежности,  выносливости и длительному сроку службы. Особой востребованности этой технике  придают современные инновационные четырехтактные двигатели серии Genesis. Их преимуществом является мощность, которая  равна двухтактным сородичам, и экономичность, не уступающая четырехтактным  аналогам.</p>
<p>  Нужно отметить, что для поддержки эксплуатационных свойств нужно иметь  различные расходные материалы и запчасти  для снегоходов Yamaha, которые способны обеспечить надёжное обслуживание  и ремонт данной техники при необходимости. Оригинальные запасные части  позволяют значительно увеличить срок службы данного агрегата, а также иметь  гарантию того, что деталь будет на все сто процентов соответствовать требуемой  модели.</p>
<p> Приобрести нужные запчасти для снегоходов Yamaha можно в нашем интернет-магазине &laquo;«MOTODOBRO»&raquo;, который готов  предложить своим заказчикам широкий ассортимент товаров для техники японского (и  не только) производителя. В наличии имеются оригинальные образцы, а также детали-аналоги  высокого качества, которые имеют идентичные параметры. Компания гарантирует  нашим клиентам оперативную доставку любой запчасти для снегоходов Yamaha за оптимальными ценами, благодаря налаженной работе транспортного  отдела и контрактам с поставщиками. </p>';
  break;

  case '/1_40_Zapchasti_dlya_gidrociklov_Kawasaki.html' : 
  $T = 'Запчасти для гидроциклов Kawasaki |Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для гидроциклов Kawasaki оптом и в розницу с доставкой. Каталог оригинальных запчастей для гидроциклов Кавасаки с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти на гидроцикл Кавасаки';
 break;
 
   case '/1_41_Zapchasti_dlya_gidrociklov_Polaris.html' : 
  $T = 'Запчасти для гидроциклов Polaris | Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для гидроциклов Polaris оптом и в розницу с доставкой. Каталог оригинальных запчастей для гидроциклов Поларис с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти на гидроцикл Polaris';
 break;
 
 
  case '/1_9_Zapchasti_dlya_katerov_Yamaha.html' : 
  $T = 'Запчасти для катеров Yamaha | Выгодные цены - купить';
  $D = 'Интернет-магазин осуществляет продажу запчастей для катеров Yamaha оптом и в розницу с доставкой. Каталог оригинальных запчастей для катеров Ямаха с выбором года выпуска. Разумная стоимость и высокое качество.';
  $H = 'Запчасти на катер Yamaha';
 break;
 
 
  case '/1_45_Zapchasti_dlya_katerov_Sea-Doo_(Bombardier).html' : 
  $T = 'Купить запчасти для катеров Sea-Doo (Bombardier)';
  $D = 'У нас Вы сможите купить запчасти для катера Sea-Doo (Bombardier) по заманчивым ценам';
  $H = 'Запчасти на катер Sea-Doo (Bombardier)';
 break;
 
}

if(isset($T)&&!empty($T)){$title = $T; unset($T);}
if(isset($D)&&!empty($D)){$meta_descr = $D; unset($D);}
if(isset($K)&&!empty($K)){$meta_key = $K; unset($K);}
if(isset($H)&&!empty($H)){$tpl_main = preg_replace('/<h1(.*)>.*<\/h1>/iuU','<h1$1>'.$H.'</h1>',$tpl_main); unset($H);}
if(isset($h2)&&!empty($h2)){$tpl_main = preg_replace('/<h2(.*)>.*<\/h2>/iuU','<h2$1>'.$h2.'</h2>',$tpl_main); unset($h2);}
if(isset($S)&&!empty($S)){$seo_text = $S; unset($S);}


//$Shaf='<div class="Shaf"></div>';
//$tpl_header =str_replace('nav-collapse',$Shaf,$tpl_header);
if($user_id) 
{
//	
	if(isset($_SESSION['user_log'])) $Shaf_login=$_SESSION['user_log']; else $Shaf_login='логин';
	$Shaf_name='Ф. И. О.';
	$tpl_main='<script type="text/javascript">jQuery(document).ready(function($){var Shaf_Show=document.getElementById("Shaf_Priv_Cab");if(Shaf_Show) {Shaf_Show.style.display="";Shaf_Show.innerHTML="<big>Личный кабинет [<a href=\'\'>Выход</a>]</big><br>Логин: '.$Shaf_login.'<br>Имя: '.$Shaf_name.'";}  });</script>'.$tpl_main;
}
else 
{$tpl_main='<script type="text/javascript">jQuery(document).ready(function($){var Shaf_Show=document.getElementById("Shaf_Priv_Cab");if(Shaf_Show) {Shaf_Show.style.display="none";}  });</script>'.$tpl_main;}



