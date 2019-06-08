# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require_relative 'billcoin_hash'

# class for testing billcoin_hash.rb
class BillcoinHashTest < Minitest::Test
  def test_calc_hash_bill
    bh = BillcoinHash.new
    assert_equal bh.calc_hash('bill'), 'f896'
  end

  def test_calc_hash_simple1
    bh = BillcoinHash.new
    assert_equal bh.calc_hash('0|0|SYSTEM>569274(100)|1553184699.650330000'), '288d'
  end

  def test_calc_hash_simple7
    bh = BillcoinHash.new
    assert_equal bh.calc_hash('7|d80e|735567>995917(1):577469>995917(1):735567>600381(1):'\
    'SYSTEM>402207(100)|1553184699.680345000'), 'a27b'
  end

  def test_convert_to_hex_bill
    bh = BillcoinHash.new
    assert_equal bh.convert_to_hex(63_638), 'f896'
  end

  def test_hash_char_b
    bh = BillcoinHash.new
    assert_equal bh.hash_char(98), 314_655_262_002_323_816_247_394_176_404_777_686_427_945_961_858_969_451_577_861_324_163_249_782_111_067_225_387_464_017_979_464_518_757_086_513_761_037_679_506_566_057_269_948_124_779_636_837_198_143_700_067_271_319_528_392_635_744_099_558_061_752_600_783_246_478_251_175_428_677_216_903_671_691_287_690_026_383_750_670_080_334_871_407_023_167_122_535_986_370_447_385_906_941_705_371_425_554_903_755_413_303_709_449_743_626_652_311_715_030_034_699_205_078_712_365_082_563_699_413_131_813_409_495_750_420_072_997_699_077_758_344_780_237_857_598_863_977_278_030_582_353_185_676_082_776_305_342_199_587_844_891_338_017_285_006_426_295_238_159_201_535_896_069_558_113_772_465_266_583_518_630_186_899_816_647_628_208_077_991_203_226_996_893_823_563_551_842_526_689_362_382_042_452_960_847_507_669_082_538_841_068_685_534_195_344_866_088_934_009_397_715_441_695_740_991_225_618_326_636_699_556_639_662_017_040_146_716_027_379_961_731_082_464_129_040_848_765_579_025_909_174_287_927_420_740_668_338_174_195_515_915_310_806_246_596_895_260_343_241_615_806_117_770_040_058_710_565_718_442_419_016_861_659_443_031_848_935_837_422_999_186_518_707_989_289_102_490_843_257_580_647_699_348_479_402_512_837_802_421_890_354_085_866_690_728_204_531_964_965_647_956_467_864_499_597_318_725_700_806_507_116_780_978_188_069_724_775_998_175_895_568_909_749_809_260_597_753_241_232_458_277_098_961_533_063_463_952_984_432_442_766_203_946_066_118_633_840_129_409_226_431_242_695_868_958_455_608_793_887_997_189_516_303_746_633_911_083_169_407_714_547_977_274_208_046_066_498_141_099_665_244_432_514_646_521_438_662_468_662_692_018_055_520_851_986_703_168_224_429_668_353_247_913_106_570_184_721_488_965_107_616_898_073_549_398_408_533_595_678_641_237_796_715_699_157_494_411_624_408_044_006_172_552_598_400_011_872_334_110_151_170_077_752_796_636_078_963_690_591_662_912_233_349_328_770_593_236_970_206_172_734_697_977_683_569_861_731_948_480_673_808_913_080_720_691_061_583_258_014_350_244_421_415_194_131_685_525_502_509_412_995_735_004_658_913_955_989_253_448_166_084_718_139_421_681_228_719_645_635_063_452_132_839_471_332_813_484_565_108_427_910_608_853_983_508_454_669_107_714_419_730_667_408_600_736_074_761_899_931_515_669_504_444_484_907_376_879_396_552_577_601_204_212_338_562_491_726_465_934_830_214_602_977_137_099_763_811_276_780_827_917_722_546_780_106_348_397_837_290_822_807_391_107_515_280_079_010_199_084_110_466_262_124_690_606_102_267_570_271_577_994_573_253_140_184_526_302_566_991_472_675_777_420_637_364_540_131_252_873_119_014_730_432_330_270_352_727_883_214_342_839_265_557_479_730_409_213_694_521_890_235_003_101_639_692_924_597_539_249_048_708_162_990_116_460_980_322_290_455_192_257_539_981_261_587_083_275_939_196_335_381_983_988_598_900_891_749_855_175_733_359_431_441_708_286_312_988_810_419_732_464_132_711_329_306_521_076_677_653_908_977_424_754_004_674_799_307_755_651_591_249_662_609_641_277_981_268_300_558_899_142_242_317_383_043_211_850_913_131_579_587_838_312_866_972_266_134_835_646_930_217_713_297_348_953_086_236_488_626_397_472_429_454_957_126_016_747_717_573_000_252_128_306_900_636_871_708_509_538_785_758_108_408_384_333_155_381_647_435_398_135_680_543_478_674_093_675_431_577_363_529_002_590_780_106_363_509_006_603_202_077_085_207_016_438_902_751_294_145_634_547_904_201_568_141_340_733_372_063_015_918_447_690_512_420_548_309_612_226_995_483_406_784_843_037_434_360_604_283_025_555_300_874_012_745_570_413_342_535_931_886_855_467_808_232_187_940_126_609_659_186_934_290_098_740_037_565_030_938_720_293_703_386_040_668_644_965_506_965_153_108_220_746_308_776_205_535_867_017_895_635_971_061_776_806_135_114_497_410_871_707_583_006_734_881_726_767_339_456_278_746_428_245_750_403_823_170_340_598_057_238_838_855_026_398_900_511_523_622_413_584_655_357_554_702_309_785_211_325_182_004_444_301_832_857_454_731_637_573_089_731_812_101_994_411_642_396_187_413_446_502_223_855_506_740_205_271_383_583_037_710_909_504_410_190_960_772_550_975_359_980_501_723_452_127_582_879_324_069_281_813_112_821_030_499_201_855_676_194_109_834_729_927_788_015_732_781_682_733_774_615_744_158_984_246_116_428_357_192_817_800_068_954_365_756_878_166_270_705_630_655_783_984_262_740_721_828_322_653_889_994_636_640_996_039_474_274_102_353_564_922_705_038_568_376_330_034_213_067_866_715_814_057_109_833_145_625_704_414_027_394_015_707_039_994_002_221_028_754_100_416_481_726_189_925_328_532_902_680_832_482_524_440_475_851_995_417_709_969_990_015_837_955_222_657_344_640_679_897_904_253_269_140_731_123_220_803_964_315_126_915_467_001_559_545_615_307_818_408_578_527_025_682_098_126_301_301_806_558_945_220_946_452_664_394_028_670_864_887_221_903_640_419_303_332_765_531_508_155_379_971_586_284_936_958_264_018_315_575_851_614_168_180_740_769_561_012_177_871_952_151_377_898_807_936_495_255_347_277_238_226_285_461_434_649_048_962_057_934_556_607_586_130_318_162_403_310_575_660_492_688_008_177_651_233_100_822_457_618_226_323_845_351_602_521_691_638_165_069_098_522_192_286_422_128_325_192_868_721_808_361_603_230_588_941_552_436_605_663_516_712_092_313_064_202_348_667_873_018_842_059_764_354_860_613_969_366_849_540_499_378_104_188_151_562_864_868_749_916_426_610_605_864_456_488_168_261_169_377_216_151_703_977_498_324_273_306_479_593_948_074_037_173_696_036_280_436_129_720_231_370_591_214_734_295_090_556_401_962_404_482_422_015_756_904_323_536_150_064_646_950_120_056_720_001_319_431_773_400_044_405_172_391_398_719_557_155_889_497_305_406_972_840_848_495_888_884_815_173_381_957_093_644_538_399_645_524_469_887_906_428_615_406_810_604_360_968_118_390_384_719_845_920_270_563_048_941_262_780_774_160_568_217_013_270_498_561_257_976_324_165_647_170_574_679_858_861_335_808_812_673_707_805_141_531_194_406_594_766_815_667_387_020_157_763_060_088_273_768_225_741_898_666_871_591_178_039_669_030_275_557_122_502_135_087_935_905_416_462_266_283_216_279_282_079_319_857_252_402_190_524_112_166_243_294_782_408_122_100_246_824_804_307_157_722_878_747_553_694_374_879_189_366_290_170_525_270_733_166_835_199_079_218_907_818_625_252_559_575_653_667_070_459_801_528_320_389_330_802_664_257_846_356_215_055_230_939_997_955_188_080_170_055_527_311_510_621_317_283_983_598_142_793_218_713_055_321_439_615_314_767_191_663_150_479_261_067_678_474_240_596_123_640_393_262_186_468_217_965_661_588_203_676_646_324_031_341_685_184_714_598_715_045_681_240_564_370_855_890_136_629_090_015_109_018_039_835_194_195_254_636_961_979_995_588_260_140_614_823_544_069_509_954_065_932_291_922_953_612_189_932_867_403_110_679_642_120_747_825_118_380_739_733_126_835_747_105_073_677_347_981_484_105_314_514_988_511_151_223_677_371_465_093_930_249_165_021_133_522_503_708_598_650_794_736_338_810_036_895_711_531_366_145_457_838_348_408_255_443_622_680_263_127_155_576_190_022_764_553_101_307_073_835_003_801_140_446_181_946_722_781_082_050_213_520_820_477_511_543_105_793_556_991_865_426_074_033_525_206_908_909_272_456_867_123_673_795_649_850_680_126_695_957_282_848_519_506_241_470_838_634_225_964_146_599_671_893_896_785_546_322_818_818_247_085_156_704_220_160_692_049_011_312_468_666_668_227_542_303_751_481_915_545_640_446_246_104_690_425_879_188_411_261_771_003_580_497_089_159_051_328_635_897_307_368_652_548_444_749_112_730_851_337_238_296_962_013_026_135_722_290_769_208_550_303_594_260_099_834_430_953_561_620_823_624_766_184_686_980_133_251_423_154_979_215_604_501_839_042_933_545_611_877_665_528_091_907_553_506_928_445_292_260_622_440_080_850_323_242_908_286_495_427_737_842_621_573_348_178_446_314_385_284_015_481_672_432_846_745_983_115_503_457_482_629_303_520_063_249_272_702_725_616_635_451_065_777_141_259_344_683_901_016_772_579_041_923_856_003_176_167_899_499_140_450_854_809_030_178_965_672_101_870_518_255_824_475_417_726_798_609_173_476_352_382_712_727_935_440_008_059_373_533_204_429_613_223_653_811_611_306_173_772_728_250_858_629_794_677_604_436_959_965_884_790_766_009_343_531_158_339_855_487_821_666_339_035_919_169_748_819_757_422_973_100_506_293_449_589_902_990_840_449_125_399_971_494_643_125_113_310_267_055_813_430_849_122_479_636_039_241_425_825_964_688_824_587_719
  end
end