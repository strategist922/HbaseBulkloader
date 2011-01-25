#!/usr/bin/env ruby

require 'rubygems'
require 'wukong'
require 'configliere' ; Configliere.use(:commandline, :env_var, :define)

Settings.define :key_field, :default => 0,  :type => Integer, :description => "What field to use as the key?"
Settings.define :bins,      :default => 10, :description => "How many bins to split keys into?"
# Settings.define :partition_file, :required => true, :description => "A yaml file containing map from string prefix to floating point value"
Settings.resolve!

PMAP = {
  "100" => 0.0000000,
  "101" => 0.0043214,
  "102" => 0.0086002,
  "103" => 0.0128372,
  "104" => 0.0170333,
  "105" => 0.0211893,
  "106" => 0.0253059,
  "107" => 0.0293838,
  "108" => 0.0334238,
  "109" => 0.0374265,
  "110" => 0.0413927,
  "111" => 0.0453230,
  "112" => 0.0492180,
  "113" => 0.0530784,
  "114" => 0.0569049,
  "115" => 0.0606978,
  "116" => 0.0644580,
  "117" => 0.0681859,
  "118" => 0.0718820,
  "119" => 0.0755470,
  "120" => 0.0791812,
  "121" => 0.0827854,
  "122" => 0.0863598,
  "123" => 0.0899051,
  "124" => 0.0934217,
  "125" => 0.0969100,
  "126" => 0.1003705,
  "127" => 0.1038037,
  "128" => 0.1072100,
  "129" => 0.1105897,
  "130" => 0.1139434,
  "131" => 0.1172713,
  "132" => 0.1205739,
  "133" => 0.1238516,
  "134" => 0.1271048,
  "135" => 0.1303338,
  "136" => 0.1335389,
  "137" => 0.1367206,
  "138" => 0.1398791,
  "139" => 0.1430148,
  "140" => 0.1461280,
  "141" => 0.1492191,
  "142" => 0.1522883,
  "143" => 0.1553360,
  "144" => 0.1583625,
  "145" => 0.1613680,
  "146" => 0.1643529,
  "147" => 0.1673173,
  "148" => 0.1702617,
  "149" => 0.1731863,
  "150" => 0.1760913,
  "151" => 0.1789769,
  "152" => 0.1818436,
  "153" => 0.1846914,
  "154" => 0.1875207,
  "155" => 0.1903317,
  "156" => 0.1931246,
  "157" => 0.1958997,
  "158" => 0.1986571,
  "159" => 0.2013971,
  "160" => 0.2041200,
  "161" => 0.2068259,
  "162" => 0.2095150,
  "163" => 0.2121876,
  "164" => 0.2148438,
  "165" => 0.2174839,
  "166" => 0.2201081,
  "167" => 0.2227165,
  "168" => 0.2253093,
  "169" => 0.2278867,
  "170" => 0.2304489,
  "171" => 0.2329961,
  "172" => 0.2355284,
  "173" => 0.2380461,
  "174" => 0.2405492,
  "175" => 0.2430380,
  "176" => 0.2455127,
  "177" => 0.2479733,
  "178" => 0.2504200,
  "179" => 0.2528530,
  "180" => 0.2552725,
  "181" => 0.2576786,
  "182" => 0.2600714,
  "183" => 0.2624511,
  "184" => 0.2648178,
  "185" => 0.2671717,
  "186" => 0.2695129,
  "187" => 0.2718416,
  "188" => 0.2741578,
  "189" => 0.2764618,
  "190" => 0.2787536,
  "191" => 0.2810334,
  "192" => 0.2833012,
  "193" => 0.2855573,
  "194" => 0.2878017,
  "195" => 0.2900346,
  "196" => 0.2922561,
  "197" => 0.2944662,
  "198" => 0.2966652,
  "199" => 0.2988531,
  "200" => 0.3010300,
  "201" => 0.3031961,
  "202" => 0.3053514,
  "203" => 0.3074960,
  "204" => 0.3096302,
  "205" => 0.3117539,
  "206" => 0.3138672,
  "207" => 0.3159703,
  "208" => 0.3180633,
  "209" => 0.3201463,
  "210" => 0.3222193,
  "211" => 0.3242825,
  "212" => 0.3263359,
  "213" => 0.3283796,
  "214" => 0.3304138,
  "215" => 0.3324385,
  "216" => 0.3344538,
  "217" => 0.3364597,
  "218" => 0.3384565,
  "219" => 0.3404441,
  "220" => 0.3424227,
  "221" => 0.3443923,
  "222" => 0.3463530,
  "223" => 0.3483049,
  "224" => 0.3502480,
  "225" => 0.3521825,
  "226" => 0.3541084,
  "227" => 0.3560259,
  "228" => 0.3579348,
  "229" => 0.3598355,
  "230" => 0.3617278,
  "231" => 0.3636120,
  "232" => 0.3654880,
  "233" => 0.3673559,
  "234" => 0.3692159,
  "235" => 0.3710679,
  "236" => 0.3729120,
  "237" => 0.3747483,
  "238" => 0.3765770,
  "239" => 0.3783979,
  "240" => 0.3802112,
  "241" => 0.3820170,
  "242" => 0.3838154,
  "243" => 0.3856063,
  "244" => 0.3873898,
  "245" => 0.3891661,
  "246" => 0.3909351,
  "247" => 0.3926970,
  "248" => 0.3944517,
  "249" => 0.3961993,
  "250" => 0.3979400,
  "251" => 0.3996737,
  "252" => 0.4014005,
  "253" => 0.4031205,
  "254" => 0.4048337,
  "255" => 0.4065402,
  "256" => 0.4082400,
  "257" => 0.4099331,
  "258" => 0.4116197,
  "259" => 0.4132998,
  "260" => 0.4149733,
  "261" => 0.4166405,
  "262" => 0.4183013,
  "263" => 0.4199557,
  "264" => 0.4216039,
  "265" => 0.4232459,
  "266" => 0.4248816,
  "267" => 0.4265113,
  "268" => 0.4281348,
  "269" => 0.4297523,
  "270" => 0.4313638,
  "271" => 0.4329693,
  "272" => 0.4345689,
  "273" => 0.4361626,
  "274" => 0.4377506,
  "275" => 0.4393327,
  "276" => 0.4409091,
  "277" => 0.4424798,
  "278" => 0.4440448,
  "279" => 0.4456042,
  "280" => 0.4471580,
  "281" => 0.4487063,
  "282" => 0.4502491,
  "283" => 0.4517864,
  "284" => 0.4533183,
  "285" => 0.4548449,
  "286" => 0.4563660,
  "287" => 0.4578819,
  "288" => 0.4593925,
  "289" => 0.4608978,
  "290" => 0.4623980,
  "291" => 0.4638930,
  "292" => 0.4653829,
  "293" => 0.4668676,
  "294" => 0.4683473,
  "295" => 0.4698220,
  "296" => 0.4712917,
  "297" => 0.4727564,
  "298" => 0.4742163,
  "299" => 0.4756712,
  "300" => 0.4771213,
  "301" => 0.4785665,
  "302" => 0.4800069,
  "303" => 0.4814426,
  "304" => 0.4828736,
  "305" => 0.4842998,
  "306" => 0.4857214,
  "307" => 0.4871384,
  "308" => 0.4885507,
  "309" => 0.4899585,
  "310" => 0.4913617,
  "311" => 0.4927604,
  "312" => 0.4941546,
  "313" => 0.4955443,
  "314" => 0.4969296,
  "315" => 0.4983106,
  "316" => 0.4996871,
  "317" => 0.5010593,
  "318" => 0.5024271,
  "319" => 0.5037907,
  "320" => 0.5051500,
  "321" => 0.5065050,
  "322" => 0.5078559,
  "323" => 0.5092025,
  "324" => 0.5105450,
  "325" => 0.5118834,
  "326" => 0.5132176,
  "327" => 0.5145478,
  "328" => 0.5158738,
  "329" => 0.5171959,
  "330" => 0.5185139,
  "331" => 0.5198280,
  "332" => 0.5211381,
  "333" => 0.5224442,
  "334" => 0.5237465,
  "335" => 0.5250448,
  "336" => 0.5263393,
  "337" => 0.5276299,
  "338" => 0.5289167,
  "339" => 0.5301997,
  "340" => 0.5314789,
  "341" => 0.5327544,
  "342" => 0.5340261,
  "343" => 0.5352941,
  "344" => 0.5365584,
  "345" => 0.5378191,
  "346" => 0.5390761,
  "347" => 0.5403295,
  "348" => 0.5415792,
  "349" => 0.5428254,
  "350" => 0.5440680,
  "351" => 0.5453071,
  "352" => 0.5465427,
  "353" => 0.5477747,
  "354" => 0.5490033,
  "355" => 0.5502284,
  "356" => 0.5514500,
  "357" => 0.5526682,
  "358" => 0.5538830,
  "359" => 0.5550944,
  "360" => 0.5563025,
  "361" => 0.5575072,
  "362" => 0.5587086,
  "363" => 0.5599066,
  "364" => 0.5611014,
  "365" => 0.5622929,
  "366" => 0.5634811,
  "367" => 0.5646661,
  "368" => 0.5658478,
  "369" => 0.5670264,
  "370" => 0.5682017,
  "371" => 0.5693739,
  "372" => 0.5705429,
  "373" => 0.5717088,
  "374" => 0.5728716,
  "375" => 0.5740313,
  "376" => 0.5751878,
  "377" => 0.5763414,
  "378" => 0.5774918,
  "379" => 0.5786392,
  "380" => 0.5797836,
  "381" => 0.5809250,
  "382" => 0.5820634,
  "383" => 0.5831988,
  "384" => 0.5843312,
  "385" => 0.5854607,
  "386" => 0.5865873,
  "387" => 0.5877110,
  "388" => 0.5888317,
  "389" => 0.5899496,
  "390" => 0.5910646,
  "391" => 0.5921768,
  "392" => 0.5932861,
  "393" => 0.5943926,
  "394" => 0.5954962,
  "395" => 0.5965971,
  "396" => 0.5976952,
  "397" => 0.5987905,
  "398" => 0.5998831,
  "399" => 0.6009729,
  "400" => 0.6020600,
  "401" => 0.6031444,
  "402" => 0.6042261,
  "403" => 0.6053050,
  "404" => 0.6063814,
  "405" => 0.6074550,
  "406" => 0.6085260,
  "407" => 0.6095944,
  "408" => 0.6106602,
  "409" => 0.6117233,
  "410" => 0.6127839,
  "411" => 0.6138418,
  "412" => 0.6148972,
  "413" => 0.6159501,
  "414" => 0.6170003,
  "415" => 0.6180481,
  "416" => 0.6190933,
  "417" => 0.6201361,
  "418" => 0.6211763,
  "419" => 0.6222140,
  "420" => 0.6232493,
  "421" => 0.6242821,
  "422" => 0.6253125,
  "423" => 0.6263404,
  "424" => 0.6273659,
  "425" => 0.6283889,
  "426" => 0.6294096,
  "427" => 0.6304279,
  "428" => 0.6314438,
  "429" => 0.6324573,
  "430" => 0.6334685,
  "431" => 0.6344773,
  "432" => 0.6354837,
  "433" => 0.6364879,
  "434" => 0.6374897,
  "435" => 0.6384893,
  "436" => 0.6394865,
  "437" => 0.6404814,
  "438" => 0.6414741,
  "439" => 0.6424645,
  "440" => 0.6434527,
  "441" => 0.6444386,
  "442" => 0.6454223,
  "443" => 0.6464037,
  "444" => 0.6473830,
  "445" => 0.6483600,
  "446" => 0.6493349,
  "447" => 0.6503075,
  "448" => 0.6512780,
  "449" => 0.6522463,
  "450" => 0.6532125,
  "451" => 0.6541765,
  "452" => 0.6551384,
  "453" => 0.6560982,
  "454" => 0.6570559,
  "455" => 0.6580114,
  "456" => 0.6589648,
  "457" => 0.6599162,
  "458" => 0.6608655,
  "459" => 0.6618127,
  "460" => 0.6627578,
  "461" => 0.6637009,
  "462" => 0.6646420,
  "463" => 0.6655810,
  "464" => 0.6665180,
  "465" => 0.6674530,
  "466" => 0.6683859,
  "467" => 0.6693169,
  "468" => 0.6702459,
  "469" => 0.6711728,
  "470" => 0.6720979,
  "471" => 0.6730209,
  "472" => 0.6739420,
  "473" => 0.6748611,
  "474" => 0.6757783,
  "475" => 0.6766936,
  "476" => 0.6776070,
  "477" => 0.6785184,
  "478" => 0.6794279,
  "479" => 0.6803355,
  "480" => 0.6812412,
  "481" => 0.6821451,
  "482" => 0.6830470,
  "483" => 0.6839471,
  "484" => 0.6848454,
  "485" => 0.6857417,
  "486" => 0.6866363,
  "487" => 0.6875290,
  "488" => 0.6884198,
  "489" => 0.6893089,
  "490" => 0.6901961,
  "491" => 0.6910815,
  "492" => 0.6919651,
  "493" => 0.6928469,
  "494" => 0.6937269,
  "495" => 0.6946052,
  "496" => 0.6954817,
  "497" => 0.6963564,
  "498" => 0.6972293,
  "499" => 0.6981005,
  "500" => 0.6989700,
  "501" => 0.6998377,
  "502" => 0.7007037,
  "503" => 0.7015680,
  "504" => 0.7024305,
  "505" => 0.7032914,
  "506" => 0.7041505,
  "507" => 0.7050080,
  "508" => 0.7058637,
  "509" => 0.7067178,
  "510" => 0.7075702,
  "511" => 0.7084209,
  "512" => 0.7092700,
  "513" => 0.7101174,
  "514" => 0.7109631,
  "515" => 0.7118072,
  "516" => 0.7126497,
  "517" => 0.7134905,
  "518" => 0.7143298,
  "519" => 0.7151674,
  "520" => 0.7160033,
  "521" => 0.7168377,
  "522" => 0.7176705,
  "523" => 0.7185017,
  "524" => 0.7193313,
  "525" => 0.7201593,
  "526" => 0.7209857,
  "527" => 0.7218106,
  "528" => 0.7226339,
  "529" => 0.7234557,
  "530" => 0.7242759,
  "531" => 0.7250945,
  "532" => 0.7259116,
  "533" => 0.7267272,
  "534" => 0.7275413,
  "535" => 0.7283538,
  "536" => 0.7291648,
  "537" => 0.7299743,
  "538" => 0.7307823,
  "539" => 0.7315888,
  "540" => 0.7323938,
  "541" => 0.7331973,
  "542" => 0.7339993,
  "543" => 0.7347998,
  "544" => 0.7355989,
  "545" => 0.7363965,
  "546" => 0.7371926,
  "547" => 0.7379873,
  "548" => 0.7387806,
  "549" => 0.7395723,
  "550" => 0.7403627,
  "551" => 0.7411516,
  "552" => 0.7419391,
  "553" => 0.7427251,
  "554" => 0.7435098,
  "555" => 0.7442930,
  "556" => 0.7450748,
  "557" => 0.7458552,
  "558" => 0.7466342,
  "559" => 0.7474118,
  "560" => 0.7481880,
  "561" => 0.7489629,
  "562" => 0.7497363,
  "563" => 0.7505084,
  "564" => 0.7512791,
  "565" => 0.7520484,
  "566" => 0.7528164,
  "567" => 0.7535831,
  "568" => 0.7543483,
  "569" => 0.7551123,
  "570" => 0.7558749,
  "571" => 0.7566361,
  "572" => 0.7573960,
  "573" => 0.7581546,
  "574" => 0.7589119,
  "575" => 0.7596678,
  "576" => 0.7604225,
  "577" => 0.7611758,
  "578" => 0.7619278,
  "579" => 0.7626786,
  "580" => 0.7634280,
  "581" => 0.7641761,
  "582" => 0.7649230,
  "583" => 0.7656686,
  "584" => 0.7664128,
  "585" => 0.7671559,
  "586" => 0.7678976,
  "587" => 0.7686381,
  "588" => 0.7693773,
  "589" => 0.7701153,
  "590" => 0.7708520,
  "591" => 0.7715875,
  "592" => 0.7723217,
  "593" => 0.7730547,
  "594" => 0.7737864,
  "595" => 0.7745170,
  "596" => 0.7752463,
  "597" => 0.7759743,
  "598" => 0.7767012,
  "599" => 0.7774268,
  "600" => 0.7781513,
  "601" => 0.7788745,
  "602" => 0.7795965,
  "603" => 0.7803173,
  "604" => 0.7810369,
  "605" => 0.7817554,
  "606" => 0.7824726,
  "607" => 0.7831887,
  "608" => 0.7839036,
  "609" => 0.7846173,
  "610" => 0.7853298,
  "611" => 0.7860412,
  "612" => 0.7867514,
  "613" => 0.7874605,
  "614" => 0.7881684,
  "615" => 0.7888751,
  "616" => 0.7895807,
  "617" => 0.7902852,
  "618" => 0.7909885,
  "619" => 0.7916906,
  "620" => 0.7923917,
  "621" => 0.7930916,
  "622" => 0.7937904,
  "623" => 0.7944880,
  "624" => 0.7951846,
  "625" => 0.7958800,
  "626" => 0.7965743,
  "627" => 0.7972675,
  "628" => 0.7979596,
  "629" => 0.7986506,
  "630" => 0.7993405,
  "631" => 0.8000294,
  "632" => 0.8007171,
  "633" => 0.8014037,
  "634" => 0.8020893,
  "635" => 0.8027737,
  "636" => 0.8034571,
  "637" => 0.8041394,
  "638" => 0.8048207,
  "639" => 0.8055009,
  "640" => 0.8061800,
  "641" => 0.8068580,
  "642" => 0.8075350,
  "643" => 0.8082110,
  "644" => 0.8088859,
  "645" => 0.8095597,
  "646" => 0.8102325,
  "647" => 0.8109043,
  "648" => 0.8115750,
  "649" => 0.8122447,
  "650" => 0.8129134,
  "651" => 0.8135810,
  "652" => 0.8142476,
  "653" => 0.8149132,
  "654" => 0.8155777,
  "655" => 0.8162413,
  "656" => 0.8169038,
  "657" => 0.8175654,
  "658" => 0.8182259,
  "659" => 0.8188854,
  "660" => 0.8195439,
  "661" => 0.8202015,
  "662" => 0.8208580,
  "663" => 0.8215135,
  "664" => 0.8221681,
  "665" => 0.8228216,
  "666" => 0.8234742,
  "667" => 0.8241258,
  "668" => 0.8247765,
  "669" => 0.8254261,
  "670" => 0.8260748,
  "671" => 0.8267225,
  "672" => 0.8273693,
  "673" => 0.8280151,
  "674" => 0.8286599,
  "675" => 0.8293038,
  "676" => 0.8299467,
  "677" => 0.8305887,
  "678" => 0.8312297,
  "679" => 0.8318698,
  "680" => 0.8325089,
  "681" => 0.8331471,
  "682" => 0.8337844,
  "683" => 0.8344207,
  "684" => 0.8350561,
  "685" => 0.8356906,
  "686" => 0.8363241,
  "687" => 0.8369567,
  "688" => 0.8375884,
  "689" => 0.8382192,
  "690" => 0.8388491,
  "691" => 0.8394780,
  "692" => 0.8401061,
  "693" => 0.8407332,
  "694" => 0.8413595,
  "695" => 0.8419848,
  "696" => 0.8426092,
  "697" => 0.8432328,
  "698" => 0.8438554,
  "699" => 0.8444772,
  "700" => 0.8450980,
  "701" => 0.8457180,
  "702" => 0.8463371,
  "703" => 0.8469553,
  "704" => 0.8475727,
  "705" => 0.8481891,
  "706" => 0.8488047,
  "707" => 0.8494194,
  "708" => 0.8500333,
  "709" => 0.8506462,
  "710" => 0.8512583,
  "711" => 0.8518696,
  "712" => 0.8524800,
  "713" => 0.8530895,
  "714" => 0.8536982,
  "715" => 0.8543060,
  "716" => 0.8549130,
  "717" => 0.8555192,
  "718" => 0.8561244,
  "719" => 0.8567289,
  "720" => 0.8573325,
  "721" => 0.8579353,
  "722" => 0.8585372,
  "723" => 0.8591383,
  "724" => 0.8597386,
  "725" => 0.8603380,
  "726" => 0.8609366,
  "727" => 0.8615344,
  "728" => 0.8621314,
  "729" => 0.8627275,
  "730" => 0.8633229,
  "731" => 0.8639174,
  "732" => 0.8645111,
  "733" => 0.8651040,
  "734" => 0.8656961,
  "735" => 0.8662873,
  "736" => 0.8668778,
  "737" => 0.8674675,
  "738" => 0.8680564,
  "739" => 0.8686444,
  "740" => 0.8692317,
  "741" => 0.8698182,
  "742" => 0.8704039,
  "743" => 0.8709888,
  "744" => 0.8715729,
  "745" => 0.8721563,
  "746" => 0.8727388,
  "747" => 0.8733206,
  "748" => 0.8739016,
  "749" => 0.8744818,
  "750" => 0.8750613,
  "751" => 0.8756399,
  "752" => 0.8762178,
  "753" => 0.8767950,
  "754" => 0.8773713,
  "755" => 0.8779470,
  "756" => 0.8785218,
  "757" => 0.8790959,
  "758" => 0.8796692,
  "759" => 0.8802418,
  "760" => 0.8808136,
  "761" => 0.8813847,
  "762" => 0.8819550,
  "763" => 0.8825245,
  "764" => 0.8830934,
  "765" => 0.8836614,
  "766" => 0.8842288,
  "767" => 0.8847954,
  "768" => 0.8853612,
  "769" => 0.8859263,
  "770" => 0.8864907,
  "771" => 0.8870544,
  "772" => 0.8876173,
  "773" => 0.8881795,
  "774" => 0.8887410,
  "775" => 0.8893017,
  "776" => 0.8898617,
  "777" => 0.8904210,
  "778" => 0.8909796,
  "779" => 0.8915375,
  "780" => 0.8920946,
  "781" => 0.8926510,
  "782" => 0.8932068,
  "783" => 0.8937618,
  "784" => 0.8943161,
  "785" => 0.8948697,
  "786" => 0.8954225,
  "787" => 0.8959747,
  "788" => 0.8965262,
  "789" => 0.8970770,
  "790" => 0.8976271,
  "791" => 0.8981765,
  "792" => 0.8987252,
  "793" => 0.8992732,
  "794" => 0.8998205,
  "795" => 0.9003671,
  "796" => 0.9009131,
  "797" => 0.9014583,
  "798" => 0.9020029,
  "799" => 0.9025468,
  "800" => 0.9030900,
  "801" => 0.9036325,
  "802" => 0.9041744,
  "803" => 0.9047155,
  "804" => 0.9052560,
  "805" => 0.9057959,
  "806" => 0.9063350,
  "807" => 0.9068735,
  "808" => 0.9074114,
  "809" => 0.9079485,
  "810" => 0.9084850,
  "811" => 0.9090209,
  "812" => 0.9095560,
  "813" => 0.9100905,
  "814" => 0.9106244,
  "815" => 0.9111576,
  "816" => 0.9116902,
  "817" => 0.9122221,
  "818" => 0.9127533,
  "819" => 0.9132839,
  "820" => 0.9138139,
  "821" => 0.9143432,
  "822" => 0.9148718,
  "823" => 0.9153998,
  "824" => 0.9159272,
  "825" => 0.9164539,
  "826" => 0.9169800,
  "827" => 0.9175055,
  "828" => 0.9180303,
  "829" => 0.9185545,
  "830" => 0.9190781,
  "831" => 0.9196010,
  "832" => 0.9201233,
  "833" => 0.9206450,
  "834" => 0.9211661,
  "835" => 0.9216865,
  "836" => 0.9222063,
  "837" => 0.9227255,
  "838" => 0.9232440,
  "839" => 0.9237620,
  "840" => 0.9242793,
  "841" => 0.9247960,
  "842" => 0.9253121,
  "843" => 0.9258276,
  "844" => 0.9263424,
  "845" => 0.9268567,
  "846" => 0.9273704,
  "847" => 0.9278834,
  "848" => 0.9283959,
  "849" => 0.9289077,
  "850" => 0.9294189,
  "851" => 0.9299296,
  "852" => 0.9304396,
  "853" => 0.9309490,
  "854" => 0.9314579,
  "855" => 0.9319661,
  "856" => 0.9324738,
  "857" => 0.9329808,
  "858" => 0.9334873,
  "859" => 0.9339932,
  "860" => 0.9344985,
  "861" => 0.9350032,
  "862" => 0.9355073,
  "863" => 0.9360108,
  "864" => 0.9365137,
  "865" => 0.9370161,
  "866" => 0.9375179,
  "867" => 0.9380191,
  "868" => 0.9385197,
  "869" => 0.9390198,
  "870" => 0.9395193,
  "871" => 0.9400182,
  "872" => 0.9405165,
  "873" => 0.9410142,
  "874" => 0.9415114,
  "875" => 0.9420081,
  "876" => 0.9425041,
  "877" => 0.9429996,
  "878" => 0.9434945,
  "879" => 0.9439889,
  "880" => 0.9444827,
  "881" => 0.9449759,
  "882" => 0.9454686,
  "883" => 0.9459607,
  "884" => 0.9464523,
  "885" => 0.9469433,
  "886" => 0.9474337,
  "887" => 0.9479236,
  "888" => 0.9484130,
  "889" => 0.9489018,
  "890" => 0.9493900,
  "891" => 0.9498777,
  "892" => 0.9503649,
  "893" => 0.9508515,
  "894" => 0.9513375,
  "895" => 0.9518230,
  "896" => 0.9523080,
  "897" => 0.9527924,
  "898" => 0.9532763,
  "899" => 0.9537597,
  "900" => 0.9542425,
  "901" => 0.9547248,
  "902" => 0.9552065,
  "903" => 0.9556878,
  "904" => 0.9561684,
  "905" => 0.9566486,
  "906" => 0.9571282,
  "907" => 0.9576073,
  "908" => 0.9580858,
  "909" => 0.9585639,
  "910" => 0.9590414,
  "911" => 0.9595184,
  "912" => 0.9599948,
  "913" => 0.9604708,
  "914" => 0.9609462,
  "915" => 0.9614211,
  "916" => 0.9618955,
  "917" => 0.9623693,
  "918" => 0.9628427,
  "919" => 0.9633155,
  "920" => 0.9637878,
  "921" => 0.9642596,
  "922" => 0.9647309,
  "923" => 0.9652017,
  "924" => 0.9656720,
  "925" => 0.9661417,
  "926" => 0.9666110,
  "927" => 0.9670797,
  "928" => 0.9675480,
  "929" => 0.9680157,
  "930" => 0.9684829,
  "931" => 0.9689497,
  "932" => 0.9694159,
  "933" => 0.9698816,
  "934" => 0.9703469,
  "935" => 0.9708116,
  "936" => 0.9712758,
  "937" => 0.9717396,
  "938" => 0.9722028,
  "939" => 0.9726656,
  "940" => 0.9731279,
  "941" => 0.9735896,
  "942" => 0.9740509,
  "943" => 0.9745117,
  "944" => 0.9749720,
  "945" => 0.9754318,
  "946" => 0.9758911,
  "947" => 0.9763500,
  "948" => 0.9768083,
  "949" => 0.9772662,
  "950" => 0.9777236,
  "951" => 0.9781805,
  "952" => 0.9786369,
  "953" => 0.9790929,
  "954" => 0.9795484,
  "955" => 0.9800034,
  "956" => 0.9804579,
  "957" => 0.9809119,
  "958" => 0.9813655,
  "959" => 0.9818186,
  "960" => 0.9822712,
  "961" => 0.9827234,
  "962" => 0.9831751,
  "963" => 0.9836263,
  "964" => 0.9840770,
  "965" => 0.9845273,
  "966" => 0.9849771,
  "967" => 0.9854265,
  "968" => 0.9858754,
  "969" => 0.9863238,
  "970" => 0.9867717,
  "971" => 0.9872192,
  "972" => 0.9876663,
  "973" => 0.9881128,
  "974" => 0.9885590,
  "975" => 0.9890046,
  "976" => 0.9894498,
  "977" => 0.9898946,
  "978" => 0.9903389,
  "979" => 0.9907827,
  "980" => 0.9912261,
  "981" => 0.9916690,
  "982" => 0.9921115,
  "983" => 0.9925535,
  "984" => 0.9929951,
  "985" => 0.9934362,
  "986" => 0.9938769,
  "987" => 0.9943172,
  "988" => 0.9947569,
  "989" => 0.9951963,
  "990" => 0.9956352,
  "991" => 0.9960737,
  "992" => 0.9965117,
  "993" => 0.9969492,
  "994" => 0.9973864,
  "995" => 0.9978231,
  "996" => 0.9982593,
  "997" => 0.9986952,
  "998" => 0.9991305,
  "999" => 0.9995655,
}

#
# Read in a tsv record stream=> partition keys into bins=> see what that looks like. Run
# this locally=> it doesn't make sense in hadoop mode.
#
class PartitionMapper < Wukong::Streamer::RecordStreamer
  def process *args
    yield get_bin(args[Settings.key_field])
  end

  def get_bin field
    prefix = field[0..2]    
    return (PMAP[prefix]*Settings.bins.to_f).to_i rescue nil
  end
  
end

class PartitionReducer < Wukong::Streamer::AccumulatingReducer
  def start! *args
    @count = 0
  end
  def accumulate *args
    @count += 1
  end
  def finalize
    yield [key, @count]
  end
end

Wukong::Script.new(PartitionMapper, PartitionReducer, :reduce_tasks => 20).run