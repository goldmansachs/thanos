load("@bazel_rules//area:def.bzl", "go_repository")
#load("@bazel_gazelle//:deps.bzl", "go_repository")

def go_dependencies():
    go_repository(
        name = "build_buf_gen_go_bufbuild_protovalidate_protocolbuffers_go",
        build_file_proto_mode = "disable",
        importpath = "buf.build/gen/go/bufbuild/protovalidate/protocolbuffers/go",
        sum = "h1:tdpHgTbmbvEIARu+bixzmleMi14+3imnpoFXz+Qzjp4=",
        version = "v1.31.0-20230802163732-1c33ebd9ecfa.1",
    )
    go_repository(
        name = "co_elastic_go_apm",
        build_file_proto_mode = "disable",
        importpath = "go.elastic.co/apm",
        sum = "h1:uPk2g/whK7c7XiZyz/YCUnAUBNPiyNeE3ARX3G6Gx7Q=",
        version = "v1.15.0",
    )
    go_repository(
        name = "co_elastic_go_apm_module_apmhttp",
        build_file_proto_mode = "disable",
        importpath = "go.elastic.co/apm/module/apmhttp",
        sum = "h1:Le/DhI0Cqpr9wG/NIGOkbz7+rOMqJrfE4MRG6q/+leU=",
        version = "v1.15.0",
    )
    go_repository(
        name = "co_elastic_go_apm_module_apmot",
        build_file_proto_mode = "disable",
        importpath = "go.elastic.co/apm/module/apmot",
        sum = "h1:yqarZ4HCIb6dLAzEVSWdppAuRhfrCfm2Z6UL+ubai2A=",
        version = "v1.15.0",
    )
    go_repository(
        name = "co_elastic_go_fastjson",
        build_file_proto_mode = "disable",
        importpath = "go.elastic.co/fastjson",
        sum = "h1:3MrGBWWVIxe/xvsbpghtkFoPciPhOCmjsR/HfwEeQR4=",
        version = "v1.1.0",
    )
    go_repository(
        name = "co_honnef_go_tools",
        build_file_proto_mode = "disable",
        importpath = "honnef.co/go/tools",
        sum = "h1:qTakTkI6ni6LFD5sBwwsdSO+AQqbSIxOauHTTQKZ/7o=",
        version = "v0.1.3",
    )
    go_repository(
        name = "com_github_ajstarks_deck",
        build_file_proto_mode = "disable",
        importpath = "github.com/ajstarks/deck",
        sum = "h1:7kQgkwGRoLzC9K0oyXdJo7nve/bynv/KwUsxbiTlzAM=",
        version = "v0.0.0-20200831202436-30c9fc6549a9",
    )
    go_repository(
        name = "com_github_ajstarks_deck_generate",
        build_file_proto_mode = "disable",
        importpath = "github.com/ajstarks/deck/generate",
        sum = "h1:iXUgAaqDcIUGbRoy2TdeofRG/j1zpGRSEmNK05T+bi8=",
        version = "v0.0.0-20210309230005-c3f852c02e19",
    )
    go_repository(
        name = "com_github_ajstarks_svgo",
        build_file_proto_mode = "disable",
        importpath = "github.com/ajstarks/svgo",
        sum = "h1:slYM766cy2nI3BwyRiyQj/Ud48djTMtMebDqepE95rw=",
        version = "v0.0.0-20211024235047-1546f124cd8b",
    )
    go_repository(
        name = "com_github_alecthomas_assert_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/alecthomas/assert/v2",
        sum = "h1:mAsH2wmvjsuvyBvAmCtm7zFsBlb8mIHx5ySLVdDZXL0=",
        version = "v2.3.0",
    )
    go_repository(
        name = "com_github_alecthomas_kingpin_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/alecthomas/kingpin/v2",
        sum = "h1:f48lwail6p8zpO1bC4TxtqACaGqHYA22qkHjHpqDjYY=",
        version = "v2.4.0",
    )
    go_repository(
        name = "com_github_alecthomas_participle_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/alecthomas/participle/v2",
        sum = "h1:z7dElHRrOEEq45F2TG5cbQihMtNTv8vwldytDj7Wrz4=",
        version = "v2.1.0",
    )
    go_repository(
        name = "com_github_alecthomas_repr",
        build_file_proto_mode = "disable",
        importpath = "github.com/alecthomas/repr",
        sum = "h1:HAzS41CIzNW5syS8Mf9UwXhNH1J9aix/BvDRf1Ml2Yk=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_alecthomas_template",
        build_file_proto_mode = "disable",
        importpath = "github.com/alecthomas/template",
        sum = "h1:JYp7IbQjafoB+tBA3gMyHYHrpOtNuDiK/uB5uXxq5wM=",
        version = "v0.0.0-20190718012654-fb15b899a751",
    )
    go_repository(
        name = "com_github_alecthomas_units",
        build_file_proto_mode = "disable",
        importpath = "github.com/alecthomas/units",
        sum = "h1:t3eaIm0rUkzbrIewtiFmMK5RXHej2XnoXNhxVsAYUfg=",
        version = "v0.0.0-20240626203959-61d1e3462e30",
    )
    go_repository(
        name = "com_github_alicebob_gopher_json",
        build_file_proto_mode = "disable",
        importpath = "github.com/alicebob/gopher-json",
        sum = "h1:HbKu58rmZpUGpz5+4FfNmIU+FmZg2P3Xaj2v2bfNWmk=",
        version = "v0.0.0-20200520072559-a9ecdc9d1d3a",
    )
    go_repository(
        name = "com_github_alicebob_miniredis_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/alicebob/miniredis/v2",
        sum = "h1:lIHHiSkEyS1MkKHCHzN+0mWrA4YdbGdimE5iZ2sHSzo=",
        version = "v2.22.0",
    )
    go_repository(
        name = "com_github_aliyun_aliyun_oss_go_sdk",
        build_file_proto_mode = "disable",
        importpath = "github.com/aliyun/aliyun-oss-go-sdk",
        sum = "h1:9gWa46nstkJ9miBReJcN8Gq34cBFbzSpQZVVT9N09TM=",
        version = "v2.2.2+incompatible",
    )
    go_repository(
        name = "com_github_andybalholm_brotli",
        build_file_proto_mode = "disable",
        importpath = "github.com/andybalholm/brotli",
        sum = "h1:8uQZIdzKmjc/iuPu7O2ioW48L81FgatrcpfFmiq/cCs=",
        version = "v1.0.5",
    )
    go_repository(
        name = "com_github_antihax_optional",
        build_file_proto_mode = "disable",
        importpath = "github.com/antihax/optional",
        sum = "h1:xK2lYat7ZLaVVcIuj82J8kIro4V6kDe0AUDFboUCwcg=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_antlr_antlr4_runtime_go_antlr_v4",
        build_file_proto_mode = "disable",
        importpath = "github.com/antlr/antlr4/runtime/Go/antlr/v4",
        sum = "h1:goHVqTbFX3AIo0tzGr14pgfAW2ZfPChKO21Z9MGf/gk=",
        version = "v4.0.0-20230512164433-5d1fd1a340c9",
    )
    go_repository(
        name = "com_github_apache_arrow_go_v10",
        build_file_proto_mode = "disable",
        importpath = "github.com/apache/arrow/go/v10",
        sum = "h1:n9dERvixoC/1JjDmBcs9FPaEryoANa2sCgVFo6ez9cI=",
        version = "v10.0.1",
    )
    go_repository(
        name = "com_github_apache_arrow_go_v11",
        build_file_proto_mode = "disable",
        importpath = "github.com/apache/arrow/go/v11",
        sum = "h1:hqauxvFQxww+0mEU/2XHG6LT7eZternCZq+A5Yly2uM=",
        version = "v11.0.0",
    )
    go_repository(
        name = "com_github_apache_arrow_go_v12",
        build_file_proto_mode = "disable",
        importpath = "github.com/apache/arrow/go/v12",
        sum = "h1:JsR2+hzYYjgSUkBSaahpqCetqZMr76djX80fF/DiJbg=",
        version = "v12.0.1",
    )
    go_repository(
        name = "com_github_apache_arrow_go_v14",
        build_file_proto_mode = "disable",
        importpath = "github.com/apache/arrow/go/v14",
        sum = "h1:N8OkaJEOfI3mEZt07BIkvo4sC6XDbL+48MBPWO5IONw=",
        version = "v14.0.2",
    )
    go_repository(
        name = "com_github_apache_thrift",
        build_file_proto_mode = "disable",
        importpath = "github.com/apache/thrift",
        sum = "h1:cMd2aj52n+8VoAtvSvLn4kDC3aZ6IAkBuqWQ2IDu7wo=",
        version = "v0.17.0",
    )
    go_repository(
        name = "com_github_armon_go_metrics",
        build_file_proto_mode = "disable",
        importpath = "github.com/armon/go-metrics",
        sum = "h1:hR91U9KYmb6bLBYLQjyM+3j+rcd/UhE+G78SFnF8gJA=",
        version = "v0.4.1",
    )
    go_repository(
        name = "com_github_armon_go_radix",
        build_file_proto_mode = "disable",
        importpath = "github.com/armon/go-radix",
        sum = "h1:F4z6KzEeeQIMeLFa97iZU6vupzoecKdU5TX24SNppXI=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_armon_go_socks5",
        build_file_proto_mode = "disable",
        importpath = "github.com/armon/go-socks5",
        sum = "h1:0CwZNZbxp69SHPdPJAN/hZIm0C4OItdklCFmMRWYpio=",
        version = "v0.0.0-20160902184237-e75332964ef5",
    )
    go_repository(
        name = "com_github_asaskevich_govalidator",
        build_file_proto_mode = "disable",
        importpath = "github.com/asaskevich/govalidator",
        sum = "h1:DklsrG3dyBCFEj5IhUbnKptjxatkF07cF2ak3yi77so=",
        version = "v0.0.0-20230301143203-a9d515a09cc2",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/aws/aws-sdk-go",
        sum = "h1:KKUZBfBoyqy5d3swXyiC7Q76ic40rYcbqH7qjh59kzU=",
        version = "v1.55.5",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/aws/aws-sdk-go-v2",
        sum = "h1:cBAYjiiexRAg9v2z9vb6IdxAa7ef4KCtjW7w7e3GxGo=",
        version = "v1.16.0",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_config",
        build_file_proto_mode = "disable",
        importpath = "github.com/aws/aws-sdk-go-v2/config",
        sum = "h1:hTIZFepYESYyowQUBo47lu69WSxsYqGUILY9Nu8+7pY=",
        version = "v1.15.1",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_credentials",
        build_file_proto_mode = "disable",
        importpath = "github.com/aws/aws-sdk-go-v2/credentials",
        sum = "h1:gc4Uhs80s60nmLon5Z4JXWinX2BkAGT0YROoUT8h8U4=",
        version = "v1.11.0",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_feature_ec2_imds",
        build_file_proto_mode = "disable",
        importpath = "github.com/aws/aws-sdk-go-v2/feature/ec2/imds",
        sum = "h1:F9Je1nq5YXfMOv6451NHvMf6U0iTWeMnsG0MMIQoUmk=",
        version = "v1.12.1",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_internal_configsources",
        build_file_proto_mode = "disable",
        importpath = "github.com/aws/aws-sdk-go-v2/internal/configsources",
        sum = "h1:KUErSJgdqmqAPBWAp6Zx9CjL0YXfytXJeXcsWnuCM1c=",
        version = "v1.1.7",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_internal_endpoints_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/aws/aws-sdk-go-v2/internal/endpoints/v2",
        sum = "h1:feVfa9eJonhJiss7g51ikjNB2DrUzbNZNvPL8pw/54k=",
        version = "v2.4.1",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_internal_ini",
        build_file_proto_mode = "disable",
        importpath = "github.com/aws/aws-sdk-go-v2/internal/ini",
        sum = "h1:adr3PfiggFtqgFofAMUFCtdvwzpf3QxPES4ezK4M3iI=",
        version = "v1.3.8",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_internal_presigned_url",
        build_file_proto_mode = "disable",
        importpath = "github.com/aws/aws-sdk-go-v2/service/internal/presigned-url",
        sum = "h1:B/SPX7J+Y0Yrcjv60Nhbh1gC2uBN47SfN8JYre6Mp4M=",
        version = "v1.9.1",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_sso",
        build_file_proto_mode = "disable",
        importpath = "github.com/aws/aws-sdk-go-v2/service/sso",
        sum = "h1:DyHctRsJIAWIvom1Itb4T84D2jwpIu+KIi3d0SFaswg=",
        version = "v1.11.1",
    )
    go_repository(
        name = "com_github_aws_aws_sdk_go_v2_service_sts",
        build_file_proto_mode = "disable",
        importpath = "github.com/aws/aws-sdk-go-v2/service/sts",
        sum = "h1:xsOtPAvHqhvQvBza5ohaUcfq1LceH2lZKMUGZJKiZiM=",
        version = "v1.16.1",
    )
    go_repository(
        name = "com_github_aws_smithy_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/aws/smithy-go",
        sum = "h1:IQ+lPZVkSM3FRtyaDox41R8YS6iwPMYIreejOgPW49g=",
        version = "v1.11.1",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_azcore",
        build_file_proto_mode = "disable",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/azcore",
        sum = "h1:nyQWyZvwGTvunIMxi1Y9uXkcyr+I7TeNrr/foo4Kpk8=",
        version = "v1.14.0",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_azidentity",
        build_file_proto_mode = "disable",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/azidentity",
        sum = "h1:tfLQ34V6F7tVSwoTf/4lH5sE0o6eCJuNDTmH09nDpbc=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_internal",
        build_file_proto_mode = "disable",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/internal",
        sum = "h1:ywEEhmNahHBihViHepv3xPBn1663uRv2t2q/ESv9seY=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_resourcemanager_compute_armcompute_v5",
        build_file_proto_mode = "disable",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/compute/armcompute/v5",
        sum = "h1:LkHbJbgF3YyvC53aqYGR+wWQDn2Rdp9AQdGndf9QvY4=",
        version = "v5.7.0",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_resourcemanager_network_armnetwork_v4",
        build_file_proto_mode = "disable",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/network/armnetwork/v4",
        sum = "h1:bXwSugBiSbgtz7rOtbfGf+woewp4f06orW9OP5BjHLA=",
        version = "v4.3.0",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_resourcemanager_storage_armstorage",
        build_file_proto_mode = "disable",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/storage/armstorage",
        sum = "h1:AifHbc4mg0x9zW52WOpKbsHaDKuRhlI7TVl47thgQ70=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_storage_azblob",
        build_file_proto_mode = "disable",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/storage/azblob",
        sum = "h1:IfFdxTUDiV58iZqPKgyWiz4X4fCxZeQ1pTQPImLYXpY=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_azure_azure_sdk_for_go_sdk_storage_azblob_testdata_perf",
        build_file_proto_mode = "disable",
        importpath = "github.com/Azure/azure-sdk-for-go/sdk/storage/azblob/testdata/perf",
        sum = "h1:45Ajiuhu6AeJTFdwxn2OWXZTQOHdXT1U/aezrVu6HIM=",
        version = "v0.0.0-20240208231215-981108a6de20",
    )
    go_repository(
        name = "com_github_azuread_microsoft_authentication_library_for_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/AzureAD/microsoft-authentication-library-for-go",
        sum = "h1:XHOnouVk1mxXfQidrMEnLlPk9UMeRtyBTnEFtxkV0kU=",
        version = "v1.2.2",
    )
    go_repository(
        name = "com_github_baidubce_bce_sdk_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/baidubce/bce-sdk-go",
        sum = "h1:yGgtPpZYUZW4uoVorQ4xnuEgVeddACydlcJKW87MDV4=",
        version = "v0.9.111",
    )
    go_repository(
        name = "com_github_baiyubin_aliyun_sts_go_sdk",
        build_file_proto_mode = "disable",
        importpath = "github.com/baiyubin/aliyun-sts-go-sdk",
        sum = "h1:ZNv7On9kyUzm7fvRZumSyy/IUiSC7AzL0I1jKKtwooA=",
        version = "v0.0.0-20180326062324-cfa1a18b161f",
    )
    go_repository(
        name = "com_github_bboreham_go_loser",
        build_file_proto_mode = "disable",
        importpath = "github.com/bboreham/go-loser",
        sum = "h1:6df1vn4bBlDDo4tARvBm7l6KA9iVMnE3NWizDeWSrps=",
        version = "v0.0.0-20230920113527-fcc2c21820a3",
    )
    go_repository(
        name = "com_github_benbjohnson_clock",
        build_file_proto_mode = "disable",
        importpath = "github.com/benbjohnson/clock",
        sum = "h1:VvXlSJBzZpA/zum6Sj74hxwYI2DIxRWuNIoXAzHZz5o=",
        version = "v1.3.5",
    )
    go_repository(
        name = "com_github_beorn7_perks",
        build_file_proto_mode = "disable",
        importpath = "github.com/beorn7/perks",
        sum = "h1:VlbKKnNfV8bJzeqoa4cOKqO6bYr3WgKZxO8Z16+hsOM=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_blang_semver_v4",
        build_file_proto_mode = "disable",
        importpath = "github.com/blang/semver/v4",
        sum = "h1:1PFHFE6yCCTv8C1TeyNNarDzntLi7wMI5i/pzqYIsAM=",
        version = "v4.0.0",
    )
    go_repository(
        name = "com_github_bluele_gcache",
        build_file_proto_mode = "disable",
        importpath = "github.com/bluele/gcache",
        sum = "h1:WcbfdXICg7G/DGBh1PFfcirkWOQV+v077yF1pSy3DGw=",
        version = "v0.0.2",
    )
    go_repository(
        name = "com_github_boombuler_barcode",
        build_file_proto_mode = "disable",
        importpath = "github.com/boombuler/barcode",
        sum = "h1:NDBbPmhS+EqABEs5Kg3n/5ZNjy73Pz7SIV+KCeqyXcs=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_bradfitz_gomemcache",
        build_file_proto_mode = "disable",
        importpath = "github.com/bradfitz/gomemcache",
        replace = "github.com/themihai/gomemcache",
        sum = "h1:7ZR3hmisBWw77ZpO1/o86g+JV3VKlk3d48jopJxzTjU=",
        version = "v0.0.0-20180902122335-24332e2d58ab",
    )
    go_repository(
        name = "com_github_bufbuild_protovalidate_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/bufbuild/protovalidate-go",
        sum = "h1:pJr07sYhliyfj/STAM7hU4J3FKpVeLVKvOBmOTN8j+s=",
        version = "v0.2.1",
    )
    go_repository(
        name = "com_github_burntsushi_toml",
        build_file_proto_mode = "disable",
        importpath = "github.com/BurntSushi/toml",
        sum = "h1:WXkYYl6Yr3qBf1K79EBnL4mak0OimBfB0XUf9Vl28OQ=",
        version = "v0.3.1",
    )
    go_repository(
        name = "com_github_burntsushi_xgb",
        build_file_proto_mode = "disable",
        importpath = "github.com/BurntSushi/xgb",
        sum = "h1:1BDTz0u9nC3//pOCMdNH+CiXJVYJh5UQNCOBG7jbELc=",
        version = "v0.0.0-20160522181843-27f122750802",
    )
    go_repository(
        name = "com_github_caio_go_tdigest",
        build_file_proto_mode = "disable",
        importpath = "github.com/caio/go-tdigest",
        sum = "h1:uoVMJ3Q5lXmVLCCqaMGHLBWnbGoN6Lpu7OAUPR60cds=",
        version = "v3.1.0+incompatible",
    )
    go_repository(
        name = "com_github_campoy_embedmd",
        build_file_proto_mode = "disable",
        importpath = "github.com/campoy/embedmd",
        sum = "h1:V4kI2qTJJLf4J29RzI/MAt2c3Bl4dQSYPuflzwFH2hY=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_cenkalti_backoff_v4",
        build_file_proto_mode = "disable",
        importpath = "github.com/cenkalti/backoff/v4",
        sum = "h1:MyRJ/UdXutAwSAT+s3wNd7MfTIcy71VQueUuFK343L8=",
        version = "v4.3.0",
    )
    go_repository(
        name = "com_github_census_instrumentation_opencensus_proto",
        build_file_proto_mode = "disable",
        importpath = "github.com/census-instrumentation/opencensus-proto",
        sum = "h1:iKLQ0xPNFxR/2hzXZMrBo8f1j86j5WHzznCCQxV/b8g=",
        version = "v0.4.1",
    )
    go_repository(
        name = "com_github_cespare_xxhash",
        build_file_proto_mode = "disable",
        importpath = "github.com/cespare/xxhash",
        sum = "h1:a6HrQnmkObjyL+Gs60czilIUGqrzKutQD6XZog3p+ko=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_cespare_xxhash_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/cespare/xxhash/v2",
        sum = "h1:UL815xU9SqsFlibzuggzjXhog7bL6oX9BbNZnL2UFvs=",
        version = "v2.3.0",
    )
    go_repository(
        name = "com_github_chromedp_cdproto",
        build_file_proto_mode = "disable",
        importpath = "github.com/chromedp/cdproto",
        sum = "h1:aPflPkRFkVwbW6dmcVqfgwp1i+UWGFH6VgR1Jim5Ygc=",
        version = "v0.0.0-20230802225258-3cf4e6d46a89",
    )
    go_repository(
        name = "com_github_chromedp_chromedp",
        build_file_proto_mode = "disable",
        importpath = "github.com/chromedp/chromedp",
        sum = "h1:dKtNz4kApb06KuSXoTQIyUC2TrA0fhGDwNZf3bcgfKw=",
        version = "v0.9.2",
    )
    go_repository(
        name = "com_github_chromedp_sysutil",
        build_file_proto_mode = "disable",
        importpath = "github.com/chromedp/sysutil",
        sum = "h1:+ZxhTpfpZlmchB58ih/LBHX52ky7w2VhQVKQMucy3Ic=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_chzyer_logex",
        build_file_proto_mode = "disable",
        importpath = "github.com/chzyer/logex",
        sum = "h1:XHDu3E6q+gdHgsdTPH6ImJMIp436vR6MPtH8gP05QzM=",
        version = "v1.2.1",
    )
    go_repository(
        name = "com_github_chzyer_readline",
        build_file_proto_mode = "disable",
        importpath = "github.com/chzyer/readline",
        sum = "h1:upd/6fQk4src78LMRzh5vItIt361/o4uq553V8B5sGI=",
        version = "v1.5.1",
    )
    go_repository(
        name = "com_github_chzyer_test",
        build_file_proto_mode = "disable",
        importpath = "github.com/chzyer/test",
        sum = "h1:p3BQDXSxOhOG0P9z6/hGnII4LGiEPOYBhs8asl/fC04=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_cilium_ebpf",
        build_file_proto_mode = "disable",
        importpath = "github.com/cilium/ebpf",
        sum = "h1:V8gS/bTCCjX9uUnkUFUpPsksM8n1lXBAvHcpiFk1X2Y=",
        version = "v0.11.0",
    )
    go_repository(
        name = "com_github_clbanning_mxj",
        build_file_proto_mode = "disable",
        importpath = "github.com/clbanning/mxj",
        sum = "h1:HuhwZtbyvyOw+3Z1AowPkU87JkJUSv751ELWaiTpj8I=",
        version = "v1.8.4",
    )
    go_repository(
        name = "com_github_cncf_udpa_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/cncf/udpa/go",
        sum = "h1:QQ3GSy+MqSHxm/d8nCtnAiZdYFd45cYZPs8vOOIYKfk=",
        version = "v0.0.0-20220112060539-c52dc94e7fbe",
    )
    go_repository(
        name = "com_github_cncf_xds_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/cncf/xds/go",
        sum = "h1:ga8SEFjZ60pxLcmhnThWgvH2wg8376yUJmPhEH4H3kw=",
        version = "v0.0.0-20240423153145-555b57ec207b",
    )
    go_repository(
        name = "com_github_codahale_hdrhistogram",
        build_file_proto_mode = "disable",
        importpath = "github.com/codahale/hdrhistogram",
        sum = "h1:qMd81Ts1T2OTKmB4acZcyKaMtRnY5Y44NuXGX2GFJ1w=",
        version = "v0.0.0-20161010025455-3a0bb77429bd",
    )
    go_repository(
        name = "com_github_code_hex_go_generics_cache",
        build_file_proto_mode = "disable",
        importpath = "github.com/Code-Hex/go-generics-cache",
        sum = "h1:6vhZGc5M7Y/YD8cIUcY8kcuQLB4cHR7U+0KMqAA0KcU=",
        version = "v1.5.1",
    )
    go_repository(
        name = "com_github_containerd_cgroups_v3",
        build_file_proto_mode = "disable",
        importpath = "github.com/containerd/cgroups/v3",
        sum = "h1:S5ByHZ/h9PMe5IOQoN7E+nMc2UcLEM/V48DGDJ9kip0=",
        version = "v3.0.3",
    )
    go_repository(
        name = "com_github_containerd_log",
        build_file_proto_mode = "disable",
        importpath = "github.com/containerd/log",
        sum = "h1:TCJt7ioM2cr/tfR8GPbGf9/VRAX8D2B4PjzCpfX540I=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_coreos_go_systemd_v22",
        build_file_proto_mode = "disable",
        importpath = "github.com/coreos/go-systemd/v22",
        sum = "h1:RrqgGjYQKalulkV8NGVIfkXQf6YYmOyiJKk8iXXhfZs=",
        version = "v22.5.0",
    )
    go_repository(
        name = "com_github_cortexproject_promqlsmith",
        build_file_proto_mode = "disable",
        importpath = "github.com/cortexproject/promqlsmith",
        sum = "h1:nOWmgQD3L/Z0bmm29iDxB7nlqjMnh7yD/PNOx9rnZmA=",
        version = "v0.0.0-20240506042652-6cfdd9739a5e",
    )
    go_repository(
        name = "com_github_creack_pty",
        build_file_proto_mode = "disable",
        importpath = "github.com/creack/pty",
        sum = "h1:uDmaGzcdjhF4i/plgjmEsriH11Y0o7RKapEf/LDaM3w=",
        version = "v1.1.9",
    )
    go_repository(
        name = "com_github_cristalhq_hedgedhttp",
        build_file_proto_mode = "disable",
        importpath = "github.com/cristalhq/hedgedhttp",
        sum = "h1:g68L9cf8uUyQKQJwciD0A1Vgbsz+QgCjuB1I8FAsCDs=",
        version = "v0.9.1",
    )
    go_repository(
        name = "com_github_data_dog_go_sqlmock",
        build_file_proto_mode = "disable",
        importpath = "github.com/DATA-DOG/go-sqlmock",
        sum = "h1:ThlnYciV1iM/V0OSF/dtkqWb6xo5qITT1TJBG1MRDJM=",
        version = "v1.4.1",
    )
    go_repository(
        name = "com_github_davecgh_go_spew",
        build_file_proto_mode = "disable",
        importpath = "github.com/davecgh/go-spew",
        sum = "h1:U9qPSI2PIWSS1VwoXQT9A3Wy9MM3WgvqSxFWenqJduM=",
        version = "v1.1.2-0.20180830191138-d8f796af33cc",
    )
    go_repository(
        name = "com_github_dennwc_varint",
        build_file_proto_mode = "disable",
        importpath = "github.com/dennwc/varint",
        sum = "h1:kGNFFSSw8ToIy3obO/kKr8U9GZYUAxQEVuix4zfDWzE=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_dgryski_go_metro",
        build_file_proto_mode = "disable",
        importpath = "github.com/dgryski/go-metro",
        sum = "h1:BS21ZUJ/B5X2UVUbczfmdWH7GapPWAhxcMsDnjJTU1E=",
        version = "v0.0.0-20200812162917-85c65e2d0165",
    )
    go_repository(
        name = "com_github_digitalocean_godo",
        build_file_proto_mode = "disable",
        importpath = "github.com/digitalocean/godo",
        sum = "h1:ziytLQi8QKtDp2K1A+YrYl2dWLHLh2uaMzWvcz9HkKg=",
        version = "v1.122.0",
    )
    go_repository(
        name = "com_github_distribution_reference",
        build_file_proto_mode = "disable",
        importpath = "github.com/distribution/reference",
        sum = "h1:/FUIFXtfc/x2gpa5/VGfiGLuOIdYa1t65IKK2OFGvA0=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_github_dnaeon_go_vcr",
        build_file_proto_mode = "disable",
        importpath = "github.com/dnaeon/go-vcr",
        sum = "h1:zHCHvJYTMh1N7xnV7zf1m1GPBF9Ad0Jk/whtQ1663qI=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_docker_docker",
        build_file_proto_mode = "disable",
        importpath = "github.com/docker/docker",
        sum = "h1:Rk9nIVdfH3+Vz4cyI/uhbINhEZ/oLmc+CBXmH6fbNk4=",
        version = "v27.2.0+incompatible",
    )
    go_repository(
        name = "com_github_docker_go_connections",
        build_file_proto_mode = "disable",
        importpath = "github.com/docker/go-connections",
        sum = "h1:El9xVISelRB7BuFusrZozjnkIM5YnzCViNKohAFqRJQ=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_docker_go_units",
        build_file_proto_mode = "disable",
        importpath = "github.com/docker/go-units",
        sum = "h1:69rxXcBk27SvSaaxTtLh/8llcHD8vYHT7WSdRZ/jvr4=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_github_docopt_docopt_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/docopt/docopt-go",
        sum = "h1:bWDMxwH3px2JBh6AyO7hdCn/PkvCZXii8TGj7sbtEbQ=",
        version = "v0.0.0-20180111231733-ee0de3bc6815",
    )
    go_repository(
        name = "com_github_dustin_go_humanize",
        build_file_proto_mode = "disable",
        importpath = "github.com/dustin/go-humanize",
        sum = "h1:GzkhY7T5VNhEkwH0PVJgjz+fX1rhBrR7pRT3mDkpeCY=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_edsrzf_mmap_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/edsrzf/mmap-go",
        sum = "h1:6EUwBLQ/Mcr1EYLE4Tn1VdW1A4ckqCQWZBw8Hr0kjpQ=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_efficientgo_core",
        build_file_proto_mode = "disable",
        importpath = "github.com/efficientgo/core",
        sum = "h1:X6CdgycYWDcbYiJr1H1+lQGzx13o7bq3EUkbB9DsSPc=",
        version = "v1.0.0-rc.3",
    )
    go_repository(
        name = "com_github_efficientgo_e2e",
        build_file_proto_mode = "disable",
        importpath = "github.com/efficientgo/e2e",
        sum = "h1:8VX23BNufsa4KCqnnEonvI3yrou2Pjp8JLcbdVn0Fs8=",
        version = "v0.14.1-0.20230710114240-c316eb95ae5b",
    )
    go_repository(
        name = "com_github_efficientgo_tools_extkingpin",
        build_file_proto_mode = "disable",
        importpath = "github.com/efficientgo/tools/extkingpin",
        sum = "h1:VaYzzXeUbC5fVheskcKVNOyJMEYD+HgrJNzIAg/mRIM=",
        version = "v0.0.0-20220817170617-6c25e3b627dd",
    )
    go_repository(
        name = "com_github_elastic_apm_agent_go",  # keep
        build_file_proto_mode = "disable",  # keep
        importpath = "go.elastic.co/apm",  # keep
        sum = "h1:uJyt6nCW9880sZhfl1tB//Jy/5TadNoAd8edRUtgb3w=",  # keep
        version = "v1.11.0",  # keep
    )

    go_repository(
        name = "com_github_elastic_go_fast_json",  # keep
        build_file_proto_mode = "disable",  # keep
        importpath = "go.elastic.co/fastjson",  # keep
        sum = "h1:3MrGBWWVIxe/xvsbpghtkFoPciPhOCmjsR/HfwEeQR4=",  # keep
        version = "v1.1.0",  # keep
    )
    go_repository(
        name = "com_github_elastic_go_licenser",
        build_file_proto_mode = "disable",
        importpath = "github.com/elastic/go-licenser",
        sum = "h1:RmRukU/JUmts+rpexAw0Fvt2ly7VVu6mw8z4HrEzObU=",
        version = "v0.3.1",
    )
    go_repository(
        name = "com_github_elastic_go_sysinfo",
        build_file_proto_mode = "disable",
        importpath = "github.com/elastic/go-sysinfo",
        sum = "h1:4Yhj+HdV6WjbCRgGdZpPJ8lZQlXZLKDAeIkmQ/VRvi4=",
        version = "v1.8.1",
    )
    go_repository(
        name = "com_github_elastic_go_windows",
        build_file_proto_mode = "disable",
        importpath = "github.com/elastic/go-windows",
        sum = "h1:AlYZOldA+UJ0/2nBuqWdo90GFCgG9xuyw9SYzGUtJm0=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_emicklei_go_restful_v3",
        build_file_proto_mode = "disable",
        importpath = "github.com/emicklei/go-restful/v3",
        sum = "h1:rAQeMHw1c7zTmncogyy8VvRZwtkmkZ4FxERmMY4rD+g=",
        version = "v3.11.0",
    )
    go_repository(
        name = "com_github_envoyproxy_go_control_plane",
        build_file_proto_mode = "disable",
        importpath = "github.com/envoyproxy/go-control-plane",
        sum = "h1:HzkeUz1Knt+3bK+8LG1bxOO/jzWZmdxpwC51i202les=",
        version = "v0.13.0",
    )
    go_repository(
        name = "com_github_envoyproxy_protoc_gen_validate",
        build_file_proto_mode = "disable",
        importpath = "github.com/envoyproxy/protoc-gen-validate",
        sum = "h1:tntQDh69XqOCOZsDz0lVJQez/2L6Uu2PdjCQwWCJ3bM=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_facette_natsort",
        build_file_proto_mode = "disable",
        importpath = "github.com/facette/natsort",
        sum = "h1:IT4JYU7k4ikYg1SCxNI1/Tieq/NFvh6dzLdgi7eu0tM=",
        version = "v0.0.0-20181210072756-2cd4dd1e2dcb",
    )
    go_repository(
        name = "com_github_fatih_color",
        build_file_proto_mode = "disable",
        importpath = "github.com/fatih/color",
        sum = "h1:zmkK9Ngbjj+K0yRhTVONQh1p/HknKYSlNT+vZCzyokM=",
        version = "v1.16.0",
    )
    go_repository(
        name = "com_github_fatih_structtag",
        build_file_proto_mode = "disable",
        importpath = "github.com/fatih/structtag",
        sum = "h1:/OdNE99OxoI/PqaW/SuSK9uxxT3f/tcSZgon/ssNSx4=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_felixge_fgprof",
        build_file_proto_mode = "disable",
        importpath = "github.com/felixge/fgprof",
        sum = "h1:8+vR6yu2vvSKn08urWyEuxx75NWPEvybbkBirEpsbVY=",
        version = "v0.9.5",
    )
    go_repository(
        name = "com_github_felixge_httpsnoop",
        build_file_proto_mode = "disable",
        importpath = "github.com/felixge/httpsnoop",
        sum = "h1:NFTV2Zj1bL4mc9sqWACXbQFVBBg2W3GPvqp8/ESS2Wg=",
        version = "v1.0.4",
    )
    go_repository(
        name = "com_github_fogleman_gg",
        build_file_proto_mode = "disable",
        importpath = "github.com/fogleman/gg",
        sum = "h1:/7zJX8F6AaYQc57WQCyN9cAIz+4bCJGO9B+dyW29am8=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_fortytw2_leaktest",
        build_file_proto_mode = "disable",
        importpath = "github.com/fortytw2/leaktest",
        sum = "h1:u8491cBMTQ8ft8aeV+adlcytMZylmA5nnwwkRZjI8vw=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_frankban_quicktest",
        build_file_proto_mode = "disable",
        importpath = "github.com/frankban/quicktest",
        sum = "h1:dfYrrRyLtiqT9GyKXgdh+k4inNeTvmGbuSgZ3lx3GhA=",
        version = "v1.14.5",
    )
    go_repository(
        name = "com_github_fsnotify_fsnotify",
        build_file_proto_mode = "disable",
        importpath = "github.com/fsnotify/fsnotify",
        sum = "h1:8JEhPFa5W2WU7YfeZzPNqzMP6Lwt7L2715Ggo0nosvA=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_github_fullstorydev_emulators_storage",
        build_file_proto_mode = "disable",
        importpath = "github.com/fullstorydev/emulators/storage",
        sum = "h1:TufioMBjkJ6/Oqmlye/ReuxHFS35HyLmypj/BNy/8GY=",
        version = "v0.0.0-20240401123056-edc69752f474",
    )
    go_repository(
        name = "com_github_fxamacker_cbor_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/fxamacker/cbor/v2",
        sum = "h1:iM5WgngdRBanHcxugY4JySA0nk1wZorNOpTgCMedv5E=",
        version = "v2.7.0",
    )
    go_repository(
        name = "com_github_ghodss_yaml",
        build_file_proto_mode = "disable",
        importpath = "github.com/ghodss/yaml",
        sum = "h1:wQHKEahhL6wmXdzwWG11gIVCkOv05bNOh+Rxn0yngAk=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_go_fonts_dejavu",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-fonts/dejavu",
        sum = "h1:JSajPXURYqpr+Cu8U9bt8K+XcACIHWqWrvWCKyeFmVQ=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_go_fonts_latin_modern",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-fonts/latin-modern",
        sum = "h1:5/Tv1Ek/QCr20C6ZOz15vw3g7GELYL98KWr8Hgo+3vk=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_go_fonts_liberation",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-fonts/liberation",
        sum = "h1:XuwG0vGHFBPRRI8Qwbi5tIvR3cku9LUfZGq/Ar16wlQ=",
        version = "v0.3.2",
    )
    go_repository(
        name = "com_github_go_fonts_stix",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-fonts/stix",
        sum = "h1:UlZlgrvvmT/58o573ot7NFw0vZasZ5I6bcIft/oMdgg=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_go_gl_glfw",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-gl/glfw",
        sum = "h1:QbL/5oDUmRBzO9/Z7Seo6zf912W/a6Sr4Eu0G/3Jho0=",
        version = "v0.0.0-20190409004039-e6da0acd62b1",
    )
    go_repository(
        name = "com_github_go_gl_glfw_v3_3_glfw",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-gl/glfw/v3.3/glfw",
        sum = "h1:WtGNWLvXpe6ZudgnXrq0barxBImvnnJoMEhXAzcbM0I=",
        version = "v0.0.0-20200222043503-6f7a984d4dc4",
    )
    go_repository(
        name = "com_github_go_ini_ini",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-ini/ini",
        sum = "h1:z6ZrTEZqSWOTyH2FlglNbNgARyHG8oLW9gMELqKr06A=",
        version = "v1.67.0",
    )
    go_repository(
        name = "com_github_go_kit_kit",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-kit/kit",
        sum = "h1:e4o3o3IsBfAKQh5Qbbiqyfu97Ku7jrO/JbohvztANh4=",
        version = "v0.12.0",
    )
    go_repository(
        name = "com_github_go_kit_log",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-kit/log",
        sum = "h1:MRVx0/zhvdseW+Gza6N9rVzU/IVzaeE1SFI4raAhmBU=",
        version = "v0.2.1",
    )
    go_repository(
        name = "com_github_go_latex_latex",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-latex/latex",
        sum = "h1:DfZQkvEbdmOe+JK2TMtBM+0I9GSdzE2y/L1/AmD8xKc=",
        version = "v0.0.0-20231108140139-5c1ce85aa4ea",
    )
    go_repository(
        name = "com_github_go_logfmt_logfmt",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-logfmt/logfmt",
        sum = "h1:wGYYu3uicYdqXVgoYbvnkrPVXkuLM1p1ifugDMEdRi4=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_github_go_logr_logr",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-logr/logr",
        sum = "h1:6pFjapn8bFcIbiKo3XT4j/BhANplGihG6tvd+8rYgrY=",
        version = "v1.4.2",
    )
    go_repository(
        name = "com_github_go_logr_stdr",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-logr/stdr",
        sum = "h1:hSWxHoqTgW2S2qGc0LTAI563KZ5YKYRhT3MFKZMbjag=",
        version = "v1.2.2",
    )
    go_repository(
        name = "com_github_go_ole_go_ole",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-ole/go-ole",
        sum = "h1:/Fpf6oFPoeFik9ty7siob0G6Ke8QvQEuVcuChpwXzpY=",
        version = "v1.2.6",
    )
    go_repository(
        name = "com_github_go_openapi_analysis",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-openapi/analysis",
        sum = "h1:ZBmNoP2h5omLKr/srIC9bfqrUGzT6g6gNv03HE9Vpj0=",
        version = "v0.22.2",
    )
    go_repository(
        name = "com_github_go_openapi_errors",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-openapi/errors",
        sum = "h1:c4xY/OLxUBSTiepAg3j/MHuAv5mJhnf53LLMWFB+u/w=",
        version = "v0.22.0",
    )
    go_repository(
        name = "com_github_go_openapi_jsonpointer",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-openapi/jsonpointer",
        sum = "h1:mQc3nmndL8ZBzStEo3JYF8wzmeWffDH4VbXz58sAx6Q=",
        version = "v0.20.2",
    )
    go_repository(
        name = "com_github_go_openapi_jsonreference",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-openapi/jsonreference",
        sum = "h1:bKlDxQxQJgwpUSgOENiMPzCTBVuc7vTdXSSgNeAhojU=",
        version = "v0.20.4",
    )
    go_repository(
        name = "com_github_go_openapi_loads",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-openapi/loads",
        sum = "h1:jDzF4dSoHw6ZFADCGltDb2lE4F6De7aWSpe+IcsRzT0=",
        version = "v0.21.5",
    )
    go_repository(
        name = "com_github_go_openapi_runtime",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-openapi/runtime",
        sum = "h1:ae53yaOoh+fx/X5Eaq8cRmavHgDma65XPZuvBqvJYto=",
        version = "v0.27.1",
    )
    go_repository(
        name = "com_github_go_openapi_spec",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-openapi/spec",
        sum = "h1:7CBlRnw+mtjFGlPDRZmAMnq35cRzI91xj03HVyUi/Do=",
        version = "v0.20.14",
    )
    go_repository(
        name = "com_github_go_openapi_strfmt",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-openapi/strfmt",
        sum = "h1:nlUS6BCqcnAk0pyhi9Y+kdDVZdZMHfEKQiS4HaMgO/c=",
        version = "v0.23.0",
    )
    go_repository(
        name = "com_github_go_openapi_swag",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-openapi/swag",
        sum = "h1:XX2DssF+mQKM2DHsbgZK74y/zj4mo9I99+89xUmuZCE=",
        version = "v0.22.9",
    )
    go_repository(
        name = "com_github_go_openapi_validate",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-openapi/validate",
        sum = "h1:2l7PJLzCis4YUGEoW6eoQw3WhyM65WSIcjX6SQnlfDw=",
        version = "v0.23.0",
    )
    go_repository(
        name = "com_github_go_pdf_fpdf",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-pdf/fpdf",
        sum = "h1:PPvSaUuo1iMi9KkaAn90NuKi+P4gwMedWPHhj8YlJQw=",
        version = "v0.9.0",
    )
    go_repository(
        name = "com_github_go_playground_assert_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-playground/assert/v2",
        sum = "h1:MsBgLAaY856+nPRTKrp3/OZK38U/wa0CcBYNjji3q3A=",
        version = "v2.0.1",
    )
    go_repository(
        name = "com_github_go_playground_locales",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-playground/locales",
        sum = "h1:HyWk6mgj5qFqCT5fjGBuRArbVDfE4hi8+e8ceBS/t7Q=",
        version = "v0.13.0",
    )
    go_repository(
        name = "com_github_go_playground_universal_translator",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-playground/universal-translator",
        sum = "h1:icxd5fm+REJzpZx7ZfpaD876Lmtgy7VtROAbHHXk8no=",
        version = "v0.17.0",
    )
    go_repository(
        name = "com_github_go_playground_validator_v10",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-playground/validator/v10",
        sum = "h1:pH2c5ADXtd66mxoE0Zm9SUhxE20r7aM3F26W0hOn+GE=",
        version = "v10.4.1",
    )
    go_repository(
        name = "com_github_go_resty_resty_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-resty/resty/v2",
        sum = "h1:x+LHXBI2nMB1vqndymf26quycC4aggYJ7DECYbiz03g=",
        version = "v2.13.1",
    )
    go_repository(
        name = "com_github_go_stack_stack",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-stack/stack",
        sum = "h1:5SgMzNM5HxrEjV0ww2lTmX6E2Izsfxas4+YHWRs3Lsk=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_github_go_task_slim_sprig",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-task/slim-sprig",
        sum = "h1:p104kn46Q8WdvHunIJ9dAyjPVtrBPhSr3KT2yUst43I=",
        version = "v0.0.0-20210107165309-348f09dbbbc0",
    )
    go_repository(
        name = "com_github_go_task_slim_sprig_v3",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-task/slim-sprig/v3",
        sum = "h1:sUs3vkvUymDpBKi3qH1YSqBQk9+9D/8M2mN1vB6EwHI=",
        version = "v3.0.0",
    )
    go_repository(
        name = "com_github_go_zookeeper_zk",
        build_file_proto_mode = "disable",
        importpath = "github.com/go-zookeeper/zk",
        sum = "h1:7M2kwOsc//9VeeFiPtf+uSJlVpU66x9Ba5+8XK7/TDg=",
        version = "v1.0.3",
    )
    go_repository(
        name = "com_github_gobwas_httphead",
        build_file_proto_mode = "disable",
        importpath = "github.com/gobwas/httphead",
        sum = "h1:exrUm0f4YX0L7EBwZHuCF4GDp8aJfVeBrlLQrs6NqWU=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_gobwas_pool",
        build_file_proto_mode = "disable",
        importpath = "github.com/gobwas/pool",
        sum = "h1:xfeeEhW7pwmX8nuLVlqbzVc7udMDrwetjEv+TZIz1og=",
        version = "v0.2.1",
    )
    go_repository(
        name = "com_github_gobwas_ws",
        build_file_proto_mode = "disable",
        importpath = "github.com/gobwas/ws",
        sum = "h1:F2aeBZrm2NDsc7vbovKrWSogd4wvfAxg0FQ89/iqOTk=",
        version = "v1.2.1",
    )
    go_repository(
        name = "com_github_goccmack_gocc",
        build_file_proto_mode = "disable",
        importpath = "github.com/goccmack/gocc",
        sum = "h1:FSii2UQeSLngl3jFoR4tUKZLprO7qUlh/TKKticc0BM=",
        version = "v0.0.0-20230228185258-2292f9e40198",
    )
    go_repository(
        name = "com_github_goccy_go_json",
        build_file_proto_mode = "disable",
        importpath = "github.com/goccy/go-json",
        sum = "h1:KZ5WoDbxAIgm2HNbYckL0se1fHD6rz5j4ywS6ebzDqA=",
        version = "v0.10.3",
    )
    go_repository(
        name = "com_github_goccy_go_yaml",
        build_file_proto_mode = "disable",
        importpath = "github.com/goccy/go-yaml",
        sum = "h1:n7Z+zx8S9f9KgzG6KtQKf+kwqXZlLNR2F6018Dgau54=",
        version = "v1.11.0",
    )
    go_repository(
        name = "com_github_godbus_dbus_v5",
        build_file_proto_mode = "disable",
        importpath = "github.com/godbus/dbus/v5",
        sum = "h1:9349emZab16e7zQvpmsbtjc18ykshndd8y2PG3sgJbA=",
        version = "v5.0.4",
    )
    go_repository(
        name = "com_github_gofrs_flock",
        build_file_proto_mode = "disable",
        importpath = "github.com/gofrs/flock",
        sum = "h1:+gYjHKf32LDeiEEFhQaotPbLuUXjY5ZqxKgXy7n59aw=",
        version = "v0.8.1",
    )
    go_repository(
        name = "com_github_gofrs_uuid",
        build_file_proto_mode = "disable",
        importpath = "github.com/gofrs/uuid",
        sum = "h1:3qXRTX8/NbyulANqlc0lchS1gqAVxRgsuW1YrTJupqA=",
        version = "v4.4.0+incompatible",
    )
    go_repository(
        name = "com_github_gogo_googleapis",
        build_file_proto_mode = "disable",
        importpath = "github.com/gogo/googleapis",
        sum = "h1:zgVt4UpGxcqVOw97aRGxT4svlcmdK35fynLNctY32zI=",
        version = "v1.4.0",
    )
    go_repository(
        name = "com_github_gogo_protobuf",
        build_file_proto_mode = "disable",
        importpath = "github.com/gogo/protobuf",
        sum = "h1:Ov1cvc58UF3b5XjBnZv7+opcTcQFZebYjWzi34vdm4Q=",
        version = "v1.3.2",
    )
    go_repository(
        name = "com_github_gogo_status",
        build_file_proto_mode = "disable",
        importpath = "github.com/gogo/status",
        sum = "h1:DuHXlSFHNKqTQ+/ACf5Vs6r4X/dH2EgIzR9Vr+H65kg=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_golang_freetype",
        build_file_proto_mode = "disable",
        importpath = "github.com/golang/freetype",
        sum = "h1:DACJavvAHhabrF08vX0COfcOBJRhZ8lUbR+ZWIs0Y5g=",
        version = "v0.0.0-20170609003504-e2365dfdc4a0",
    )
    go_repository(
        name = "com_github_golang_glog",
        build_file_proto_mode = "disable",
        importpath = "github.com/golang/glog",
        sum = "h1:OptwRhECazUx5ix5TTWC3EZhsZEHWcYWY4FQHTIubm4=",
        version = "v1.2.1",
    )
    go_repository(
        name = "com_github_golang_groupcache",
        build_file_proto_mode = "disable",
        importpath = "github.com/golang/groupcache",
        sum = "h1:oI5xCqsCo564l8iNU+DwB5epxmsaqB+rhGL0m5jtYqE=",
        version = "v0.0.0-20210331224755-41bb18bfe9da",
    )
    go_repository(
        name = "com_github_golang_jwt_jwt_v5",
        build_file_proto_mode = "disable",
        importpath = "github.com/golang-jwt/jwt/v5",
        sum = "h1:OuVbFODueb089Lh128TAcimifWaLhJwVflnrgM17wHk=",
        version = "v5.2.1",
    )
    go_repository(
        name = "com_github_golang_mock",
        build_file_proto_mode = "disable",
        importpath = "github.com/golang/mock",
        sum = "h1:ErTB+efbowRARo13NNdxyJji2egdxLGQhRaY+DUumQc=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_github_golang_protobuf",
        build_file_proto_mode = "disable",
        importpath = "github.com/golang/protobuf",
        sum = "h1:i7eJL8qZTpSEXOPTxNKhASYpMn+8e5Q6AdndVa1dWek=",
        version = "v1.5.4",
    )
    go_repository(
        name = "com_github_golang_snappy",
        build_file_proto_mode = "disable",
        importpath = "github.com/golang/snappy",
        sum = "h1:yAGX7huGHXlcLOEtBnF4w7FQwA26wojNCwOYAEhLjQM=",
        version = "v0.0.4",
    )
    go_repository(
        name = "com_github_google_btree",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/btree",
        sum = "h1:xf4v41cLI2Z6FxbKm+8Bu+m8ifhj15JuZ9sa0jZCMUU=",
        version = "v1.1.2",
    )
    go_repository(
        name = "com_github_google_cel_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/cel-go",
        sum = "h1:s2151PDGy/eqpCI80/8dl4VL3xTkqI/YubXLXCFw0mw=",
        version = "v0.17.1",
    )
    go_repository(
        name = "com_github_google_flatbuffers",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/flatbuffers",
        sum = "h1:M9dgRyhJemaM4Sw8+66GHBu8ioaQmyPLg1b8VwK5WJg=",
        version = "v23.5.26+incompatible",
    )
    go_repository(
        name = "com_github_google_gnostic_models",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/gnostic-models",
        sum = "h1:yo/ABAfM5IMRsS1VnXjTBvUb61tFIHozhlYvRgGre9I=",
        version = "v0.6.8",
    )
    go_repository(
        name = "com_github_google_go_cmp",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/go-cmp",
        sum = "h1:ofyhxvXcZhMsU5ulbFiLKl/XBFqE1GSq7atu8tAmTRI=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_github_google_go_pkcs11",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/go-pkcs11",
        sum = "h1:PVRnTgtArZ3QQqTGtbtjtnIkzl2iY2kt24yqbrf7td8=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_github_google_go_querystring",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/go-querystring",
        sum = "h1:AnCroh3fv4ZBgVIf1Iwtovgjaw/GiKJo8M8yD/fhyJ8=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_google_gofuzz",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/gofuzz",
        sum = "h1:xRy4A+RhZaiKjJ1bPfwQ8sedCA+YS2YcCHW6ec7JMi0=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_google_martian",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/martian",
        sum = "h1:/CP5g8u/VJHijgedC/Legn3BAbAaWPgecwXBIDzw5no=",
        version = "v2.1.0+incompatible",
    )
    go_repository(
        name = "com_github_google_martian_v3",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/martian/v3",
        sum = "h1:DIhPTQrbPkgs2yJYdXU/eNACCG5DVQjySNRNlflZ9Fc=",
        version = "v3.3.3",
    )
    go_repository(
        name = "com_github_google_pprof",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/pprof",
        sum = "h1:5iH8iuqE5apketRbSFBy+X1V0o+l+8NF1avt4HWl7cA=",
        version = "v0.0.0-20240827171923-fa2c70bbbfe5",
    )
    go_repository(
        name = "com_github_google_renameio",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/renameio",
        sum = "h1:GOZbcHa3HfsPKPlmyPyN2KEohoMXOhdMbHrvbpl2QaA=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_google_s2a_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/s2a-go",
        sum = "h1:zZDs9gcbt9ZPLV0ndSyQk6Kacx2g/X+SKYovpnz3SMM=",
        version = "v0.1.8",
    )
    go_repository(
        name = "com_github_google_uuid",
        build_file_proto_mode = "disable",
        importpath = "github.com/google/uuid",
        sum = "h1:NIvaJDMOsjHA8n1jAhLSgzrAzy1Hgr+hNrb57e+94F0=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_github_googleapis_enterprise_certificate_proxy",
        build_file_proto_mode = "disable",
        importpath = "github.com/googleapis/enterprise-certificate-proxy",
        sum = "h1:XYIDZApgAnrN1c855gTgghdIA6Stxb52D5RnLI1SLyw=",
        version = "v0.3.4",
    )
    go_repository(
        name = "com_github_googleapis_gax_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/googleapis/gax-go",
        sum = "h1:silFMLAnr330+NRuag/VjIGF7TLp/LBrV2CJKFLWEww=",
        version = "v2.0.2+incompatible",
    )
    go_repository(
        name = "com_github_googleapis_gax_go_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/googleapis/gax-go/v2",
        sum = "h1:yitjD5f7jQHhyDsnhKEBU52NdvvdSeGzlAnDPT0hH1s=",
        version = "v2.13.0",
    )
    go_repository(
        name = "com_github_googleapis_go_type_adapters",
        build_file_proto_mode = "disable",
        importpath = "github.com/googleapis/go-type-adapters",
        sum = "h1:9XdMn+d/G57qq1s8dNc5IesGCXHf6V2HZ2JwRxfA2tA=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_googleapis_google_cloud_go_testing",
        build_file_proto_mode = "disable",
        importpath = "github.com/googleapis/google-cloud-go-testing",
        sum = "h1:tlyzajkF3030q6M8SvmJSemC9DTHL/xaMa18b65+JM4=",
        version = "v0.0.0-20200911160855-bcd43fbb19e8",
    )
    go_repository(
        name = "com_github_googlecloudplatform_opentelemetry_operations_go_exporter_trace",
        build_file_proto_mode = "disable",
        importpath = "github.com/GoogleCloudPlatform/opentelemetry-operations-go/exporter/trace",
        sum = "h1:i84ZOPT35YCJROyuf97VP/VEdYhQce/8NTLOWq5tqJw=",
        version = "v1.8.3",
    )
    go_repository(
        name = "com_github_googlecloudplatform_opentelemetry_operations_go_internal_resourcemapping",
        build_file_proto_mode = "disable",
        importpath = "github.com/GoogleCloudPlatform/opentelemetry-operations-go/internal/resourcemapping",
        sum = "h1:FhsH8qgWFkkPlPXBZ68uuT/FH/R+DLTtVPxjLEBs1v4=",
        version = "v0.32.3",
    )
    go_repository(
        name = "com_github_googleinterns_cloud_operations_api_mock",
        build_file_proto_mode = "disable",
        importpath = "github.com/googleinterns/cloud-operations-api-mock",
        sum = "h1:eHv/jVY/JNop1xg2J9cBb4EzyMpWZoNCP1BslSAIkOI=",
        version = "v0.0.0-20200709193332-a1e58c29bdd3",
    )
    go_repository(
        name = "com_github_gophercloud_gophercloud",
        build_file_proto_mode = "disable",
        importpath = "github.com/gophercloud/gophercloud",
        sum = "h1:Bt9zQDhPrbd4qX7EILGmy+i7GP35cc+AAL2+wIJpUE8=",
        version = "v1.14.0",
    )
    go_repository(
        name = "com_github_gorilla_mux",
        build_file_proto_mode = "disable",
        importpath = "github.com/gorilla/mux",
        sum = "h1:i40aqfkR1h2SlN9hojwV5ZA91wcXFOvkdNIeFDP5koI=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_github_gorilla_websocket",
        build_file_proto_mode = "disable",
        importpath = "github.com/gorilla/websocket",
        sum = "h1:PPwGk2jz7EePpoHN/+ClbZu8SPxiqlu12wZP/3sWmnc=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_github_grafana_regexp",
        build_file_proto_mode = "disable",
        importpath = "github.com/grafana/regexp",
        sum = "h1:GN2Lv3MGO7AS6PrRoT6yV5+wkrOpcszoIsO4+4ds248=",
        version = "v0.0.0-20240518133315-a468a5bfb3bc",
    )
    go_repository(
        name = "com_github_gregjones_httpcache",
        build_file_proto_mode = "disable",
        importpath = "github.com/gregjones/httpcache",
        sum = "h1:pdN6V1QBWetyv/0+wjACpqVH+eVULgEjkurDLq3goeM=",
        version = "v0.0.0-20180305231024-9cad4c3443a7",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_go_grpc_middleware_providers_prometheus",
        build_file_proto_mode = "disable",
        importpath = "github.com/grpc-ecosystem/go-grpc-middleware/providers/prometheus",
        sum = "h1:qnpSQwGEnkcRpTqNOIR6bJbR0gAorgP9CSALpRcKoAA=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_go_grpc_middleware_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/grpc-ecosystem/go-grpc-middleware/v2",
        sum = "h1:pRhl55Yx1eC7BZ1N+BBWwnKaMyD8uC+34TLdndZMAKk=",
        version = "v2.1.0",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_grpc_gateway",
        build_file_generation = "on",  # keep
        build_file_proto_mode = "disable",
        importpath = "github.com/grpc-ecosystem/grpc-gateway",
        sum = "h1:gmcG1KaJ57LophUzW0Hy8NmPhnMZb4M0+kPpLofRdBo=",
        version = "v1.16.0",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_grpc_gateway_v2",
        build_file_generation = "on",
        build_file_proto_mode = "disable",
        importpath = "github.com/grpc-ecosystem/grpc-gateway/v2",
        sum = "h1:asbCHRVmodnJTuQ3qamDwqVOIjwqUPTYmYuemVOx+Ys=",
        version = "v2.22.0",
    )
    go_repository(
        name = "com_github_grpc_ecosystem_grpc_opentracing",
        build_file_proto_mode = "disable",
        importpath = "github.com/grpc-ecosystem/grpc-opentracing",
        sum = "h1:MJG/KsmcqMwFAkh8mTnAwhyKoB+sTAnY4CACC110tbU=",
        version = "v0.0.0-20180507213350-8e809c8a8645",
    )
    go_repository(
        name = "com_github_hashicorp_consul_api",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/consul/api",
        sum = "h1:P6slzxDLBOxUSj3fWo2o65VuKtbtOXFi7TSSgtXutuE=",
        version = "v1.29.4",
    )
    go_repository(
        name = "com_github_hashicorp_cronexpr",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/cronexpr",
        sum = "h1:wG/ZYIKT+RT3QkOdgYc+xsKWVRgnxJ1OJtjjy84fJ9A=",
        version = "v1.1.2",
    )
    go_repository(
        name = "com_github_hashicorp_errwrap",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/errwrap",
        sum = "h1:OxrOeh75EUXMY8TBjag2fzXGZ40LB6IKw45YeGUDY2I=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_hashicorp_go_cleanhttp",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/go-cleanhttp",
        sum = "h1:035FKYIWjmULyFRBKPs8TBQoi0x6d9G4xc9neXJWAZQ=",
        version = "v0.5.2",
    )
    go_repository(
        name = "com_github_hashicorp_go_hclog",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/go-hclog",
        sum = "h1:Qr2kF+eVWjTiYmU7Y31tYlP1h0q/X3Nl3tPGdaB11/k=",
        version = "v1.6.3",
    )
    go_repository(
        name = "com_github_hashicorp_go_immutable_radix",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/go-immutable-radix",
        sum = "h1:DKHmCUm2hRBK510BaiZlwvpD40f8bJFeZnpfm2KLowc=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_github_hashicorp_go_msgpack",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/go-msgpack",
        sum = "h1:zKjpN5BK/P5lMYrLmBHdBULWbJ0XpYR+7NGzqkZzoD4=",
        version = "v0.5.3",
    )
    go_repository(
        name = "com_github_hashicorp_go_multierror",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/go-multierror",
        sum = "h1:H5DkEtf6CXdFp0N0Em5UCwQpXMWke8IA0+lD48awMYo=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_hashicorp_go_retryablehttp",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/go-retryablehttp",
        sum = "h1:C8hUCYzor8PIfXHa4UrZkU4VvK8o9ISHxT2Q8+VepXU=",
        version = "v0.7.7",
    )
    go_repository(
        name = "com_github_hashicorp_go_rootcerts",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/go-rootcerts",
        sum = "h1:jzhAVGtqPKbwpyCPELlgNWhE1znq+qwJtW5Oi2viEzc=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_hashicorp_go_sockaddr",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/go-sockaddr",
        sum = "h1:RSG8rKU28VTUTvEKghe5gIhIQpv8evvNpnDEyqO4u9I=",
        version = "v1.0.6",
    )
    go_repository(
        name = "com_github_hashicorp_go_version",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/go-version",
        sum = "h1:5tqGy27NaOTB8yJKUZELlFAS/LTKJkrmONwQKeRZfjY=",
        version = "v1.7.0",
    )
    go_repository(
        name = "com_github_hashicorp_golang_lru",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/golang-lru",
        sum = "h1:uL2shRDx7RTrOrTCUZEGP/wJUFiUI8QT6E7z5o8jga4=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_github_hashicorp_golang_lru_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/golang-lru/v2",
        sum = "h1:a+bsQ5rvGLjzHuww6tVxozPZFVghXaHOwFs4luLUK2k=",
        version = "v2.0.7",
    )
    go_repository(
        name = "com_github_hashicorp_memberlist",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/memberlist",
        sum = "h1:EtYPN8DpAURiapus508I4n9CzHs2W+8NZGbmmR/prTM=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_github_hashicorp_nomad_api",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/nomad/api",
        sum = "h1:fgVfQ4AC1avVOnu2cfms8VAiD8lUq3vWI8mTocOXN/w=",
        version = "v0.0.0-20240717122358-3d93bd3778f3",
    )
    go_repository(
        name = "com_github_hashicorp_serf",
        build_file_proto_mode = "disable",
        importpath = "github.com/hashicorp/serf",
        sum = "h1:Z1H2J60yRKvfDYAOZLd2MU0ND4AH/WDz7xYHDWQsIPY=",
        version = "v0.10.1",
    )
    go_repository(
        name = "com_github_hdrhistogram_hdrhistogram_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/HdrHistogram/hdrhistogram-go",
        sum = "h1:5IcZpTvzydCQeHzK4Ef/D5rrSqwxob0t8PQPMybUNFM=",
        version = "v1.1.2",
    )
    go_repository(
        name = "com_github_hetznercloud_hcloud_go_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/hetznercloud/hcloud-go/v2",
        sum = "h1:jq0GP4QaYE5d8xR/Zw17s9qoaESRJMXfGmtD1a/qckQ=",
        version = "v2.13.1",
    )
    go_repository(
        name = "com_github_hexops_gotextdiff",
        build_file_proto_mode = "disable",
        importpath = "github.com/hexops/gotextdiff",
        sum = "h1:gitA9+qJrrTCsiCl7+kh75nPqQt1cx4ZkudSTLoUqJM=",
        version = "v1.0.3",
    )
    go_repository(
        name = "com_github_hpcloud_tail",
        build_file_proto_mode = "disable",
        importpath = "github.com/hpcloud/tail",
        sum = "h1:nfCOvKYfkgYP8hkirhJocXT2+zOD8yUNjXaWfTlyFKI=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_huaweicloud_huaweicloud_sdk_go_obs",
        build_file_proto_mode = "disable",
        importpath = "github.com/huaweicloud/huaweicloud-sdk-go-obs",
        sum = "h1:tKTaPHNVwikS3I1rdyf1INNvgJXWSf/+TzqsiGbrgnQ=",
        version = "v3.23.3+incompatible",
    )
    go_repository(
        name = "com_github_iancoleman_strcase",
        build_file_proto_mode = "disable",
        importpath = "github.com/iancoleman/strcase",
        sum = "h1:nTXanmYxhfFAMjZL34Ov6gkzEsSJZ5DbhxWjvSASxEI=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_github_ianlancetaylor_demangle",
        build_file_proto_mode = "disable",
        importpath = "github.com/ianlancetaylor/demangle",
        sum = "h1:KwWnWVWCNtNq/ewIX7HIKnELmEx2nDP42yskD/pi7QE=",
        version = "v0.0.0-20240312041847-bd984b5ce465",
    )
    go_repository(
        name = "com_github_imdario_mergo",
        build_file_proto_mode = "disable",
        importpath = "github.com/imdario/mergo",
        sum = "h1:wwQJbIsHYGMUyLSPrEq1CT16AhnhNJQ51+4fdHUnCl4=",
        version = "v0.3.16",
    )
    go_repository(
        name = "com_github_ionos_cloud_sdk_go_v6",
        build_file_proto_mode = "disable",
        importpath = "github.com/ionos-cloud/sdk-go/v6",
        sum = "h1:mxxN+frNVmbFrmmFfXnBC3g2USYJrl6mc1LW2iNYbFY=",
        version = "v6.2.1",
    )
    go_repository(
        name = "com_github_jcchavezs_porto",
        build_file_proto_mode = "disable",
        importpath = "github.com/jcchavezs/porto",
        sum = "h1:Xmxxn25zQMmgE7/yHYmh19KcItG81hIwfbEEFnd6w/Q=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_jessevdk_go_flags",
        build_file_proto_mode = "disable",
        importpath = "github.com/jessevdk/go-flags",
        sum = "h1:1jKYvbxEjfUl0fmqTCOfonvskHHXMjBySTLW4y9LFvc=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_github_jmespath_go_jmespath",
        build_file_proto_mode = "disable",
        importpath = "github.com/jmespath/go-jmespath",
        sum = "h1:BEgLn5cpjn8UN1mAw4NjwDrS35OdebyEtFe+9YPoQUg=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_jmespath_go_jmespath_internal_testify",
        build_file_proto_mode = "disable",
        importpath = "github.com/jmespath/go-jmespath/internal/testify",
        sum = "h1:shLQSRRSCCPj3f2gpwzGwWFoC7ycTf1rcQZHOlsJ6N8=",
        version = "v1.5.1",
    )
    go_repository(
        name = "com_github_joeshaw_multierror",
        build_file_proto_mode = "disable",
        importpath = "github.com/joeshaw/multierror",
        sum = "h1:rp+c0RAYOWj8l6qbCUTSiRLG/iKnW3K3/QfPPuSsBt4=",
        version = "v0.0.0-20140124173710-69b34d4ec901",
    )
    go_repository(
        name = "com_github_johncgriffin_overflow",
        build_file_proto_mode = "disable",
        importpath = "github.com/JohnCGriffin/overflow",
        sum = "h1:RGWPOewvKIROun94nF7v2cua9qP+thov/7M50KEoeSU=",
        version = "v0.0.0-20211019200055-46fa312c352c",
    )
    go_repository(
        name = "com_github_josharian_intern",
        build_file_proto_mode = "disable",
        importpath = "github.com/josharian/intern",
        sum = "h1:vlS4z54oSdjm0bgjRigI+G1HpF+tI+9rE5LLzOg8HmY=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_jpillora_backoff",
        build_file_proto_mode = "disable",
        importpath = "github.com/jpillora/backoff",
        sum = "h1:uvFg412JmmHBHw7iwprIxkPMI+sGQ4kzOWsMeHnm2EA=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_json_iterator_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/json-iterator/go",
        sum = "h1:PV8peI4a0ysnczrg+LtxykD8LfKY9ML6u2jnxaEnrnM=",
        version = "v1.1.12",
    )
    go_repository(
        name = "com_github_jstemmer_go_junit_report",
        build_file_proto_mode = "disable",
        importpath = "github.com/jstemmer/go-junit-report",
        sum = "h1:6QPYqodiu3GuPL+7mfx+NwDdp2eTkp9IfEUpgAwUN0o=",
        version = "v0.9.1",
    )
    go_repository(
        name = "com_github_julienschmidt_httprouter",
        build_file_proto_mode = "disable",
        importpath = "github.com/julienschmidt/httprouter",
        sum = "h1:U0609e9tgbseu3rBINet9P48AI/D3oJs4dN7jwJOQ1U=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_jung_kurt_gofpdf",
        build_file_proto_mode = "disable",
        importpath = "github.com/jung-kurt/gofpdf",
        sum = "h1:PJr+ZMXIecYc1Ey2zucXdR73SMBtgjPgwa31099IMv0=",
        version = "v1.0.3-0.20190309125859-24315acbbda5",
    )
    go_repository(
        name = "com_github_kballard_go_shellquote",
        build_file_proto_mode = "disable",
        importpath = "github.com/kballard/go-shellquote",
        sum = "h1:Z9n2FFNUXsshfwJMBgNA0RU6/i7WVaAegv3PtuIHPMs=",
        version = "v0.0.0-20180428030007-95032a82bc51",
    )
    go_repository(
        name = "com_github_kimmachinegun_automemlimit",
        build_file_proto_mode = "disable",
        importpath = "github.com/KimMachineGun/automemlimit",
        sum = "h1:ILa9j1onAAMadBsyyUJv5cack8Y1WT26yLj/V+ulKp8=",
        version = "v0.6.1",
    )
    go_repository(
        name = "com_github_kisielk_errcheck",
        build_file_proto_mode = "disable",
        importpath = "github.com/kisielk/errcheck",
        sum = "h1:e8esj/e4R+SAOwFwN+n3zr0nYeCyeweozKfO23MvHzY=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_github_kisielk_gotool",
        build_file_proto_mode = "disable",
        importpath = "github.com/kisielk/gotool",
        sum = "h1:AV2c/EiW3KqPNT9ZKl07ehoAGi4C5/01Cfbblndcapg=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_klauspost_asmfmt",
        build_file_proto_mode = "disable",
        importpath = "github.com/klauspost/asmfmt",
        sum = "h1:4Ri7ox3EwapiOjCki+hw14RyKk201CN4rzyCJRFLpK4=",
        version = "v1.3.2",
    )
    go_repository(
        name = "com_github_klauspost_compress",
        build_file_proto_mode = "disable",
        importpath = "github.com/klauspost/compress",
        sum = "h1:In6xLpyWOi1+C7tXUUWv2ot1QvBjxevKAaI6IXrJmUc=",
        version = "v1.17.11",
    )
    go_repository(
        name = "com_github_klauspost_cpuid_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/klauspost/cpuid/v2",
        sum = "h1:+StwCXwm9PdpiEkPyzBXIy+M9KUb4ODm0Zarf1kS5BM=",
        version = "v2.2.8",
    )
    go_repository(
        name = "com_github_kolo_xmlrpc",
        build_file_proto_mode = "disable",
        importpath = "github.com/kolo/xmlrpc",
        sum = "h1:udzkj9S/zlT5X367kqJis0QP7YMxobob6zhzq6Yre00=",
        version = "v0.0.0-20220921171641-a4b6fa1dd06b",
    )
    go_repository(
        name = "com_github_konsorten_go_windows_terminal_sequences",
        build_file_proto_mode = "disable",
        importpath = "github.com/konsorten/go-windows-terminal-sequences",
        sum = "h1:CE8S1cTafDpPvMhIxNJKvHsGVBgn1xWYf1NbHQhywc8=",
        version = "v1.0.3",
    )
    go_repository(
        name = "com_github_kr_fs",
        build_file_proto_mode = "disable",
        importpath = "github.com/kr/fs",
        sum = "h1:Jskdu9ieNAYnjxsi0LbQp1ulIKZV1LAFgK1tWhpZgl8=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_kr_logfmt",
        build_file_proto_mode = "disable",
        importpath = "github.com/kr/logfmt",
        sum = "h1:T+h1c/A9Gawja4Y9mFVWj2vyii2bbUNDw3kt9VxK2EY=",
        version = "v0.0.0-20140226030751-b84e30acd515",
    )
    go_repository(
        name = "com_github_kr_pretty",
        build_file_proto_mode = "disable",
        importpath = "github.com/kr/pretty",
        sum = "h1:flRD4NNwYAUpkphVc1HcthR4KEIFJ65n8Mw5qdRn3LE=",
        version = "v0.3.1",
    )
    go_repository(
        name = "com_github_kr_pty",
        build_file_proto_mode = "disable",
        importpath = "github.com/kr/pty",
        sum = "h1:VkoXIwSboBpnk99O/KFauAEILuNHv5DVFKZMBN/gUgw=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_kr_text",
        build_file_proto_mode = "disable",
        importpath = "github.com/kr/text",
        sum = "h1:5Nx0Ya0ZqY2ygV366QzturHI13Jq95ApcVaJBhpS+AY=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_kylelemons_godebug",
        build_file_proto_mode = "disable",
        importpath = "github.com/kylelemons/godebug",
        sum = "h1:RPNrshWIDI6G2gRW9EHilWtl7Z6Sb1BR0xunSBf0SNc=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_leanovate_gopter",
        build_file_proto_mode = "disable",
        importpath = "github.com/leanovate/gopter",
        sum = "h1:fQjYxZaynp97ozCzfOyOuAGOU4aU/z37zf/tOujFk7c=",
        version = "v0.2.9",
    )
    go_repository(
        name = "com_github_ledongthuc_pdf",
        build_file_proto_mode = "disable",
        importpath = "github.com/ledongthuc/pdf",
        sum = "h1:6Yzfa6GP0rIo/kULo2bwGEkFvCePZ3qHDDTC3/J9Swo=",
        version = "v0.0.0-20220302134840-0c2507a12d80",
    )
    go_repository(
        name = "com_github_leesper_go_rng",
        build_file_proto_mode = "disable",
        importpath = "github.com/leesper/go_rng",
        sum = "h1:X/79QL0b4YJVO5+OsPH9rF2u428CIrGL/jLmPsoOQQ4=",
        version = "v0.0.0-20190531154944-a612b043e353",
    )
    go_repository(
        name = "com_github_leodido_go_urn",
        build_file_proto_mode = "disable",
        importpath = "github.com/leodido/go-urn",
        sum = "h1:hpXL4XnriNwQ/ABnpepYM/1vCLWNDfUNts8dX3xTG6Y=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_lightstep_lightstep_tracer_common_golang_gogo",
        build_file_proto_mode = "disable",
        importpath = "github.com/lightstep/lightstep-tracer-common/golang/gogo",
        sum = "h1:YjW+hUb8Fh2S58z4av4t/0cBMK/Q0aP48RocCFsC8yI=",
        version = "v0.0.0-20210210170715-a8dfcb80d3a7",
    )
    go_repository(
        name = "com_github_lightstep_lightstep_tracer_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/lightstep/lightstep-tracer-go",
        sum = "h1:sGVnz8h3jTQuHKMbUe2949nXm3Sg09N1UcR3VoQNN5E=",
        version = "v0.25.0",
    )
    go_repository(
        name = "com_github_linode_linodego",
        build_file_proto_mode = "disable",
        importpath = "github.com/linode/linodego",
        sum = "h1:7ESY0PwK94hoggoCtIroT1Xk6b1flrFBNZ6KwqbTqlI=",
        version = "v1.40.0",
    )
    go_repository(
        name = "com_github_lovoo_gcloud_opentracing",
        build_file_proto_mode = "disable",
        importpath = "github.com/lovoo/gcloud-opentracing",
        sum = "h1:nAeKG70rIsog0TelcEtt6KU0Y1s5qXtsDLnHp0urPLU=",
        version = "v0.3.0",
    )
    go_repository(
        name = "com_github_lufia_plan9stats",
        build_file_proto_mode = "disable",
        importpath = "github.com/lufia/plan9stats",
        sum = "h1:6E+4a0GO5zZEnZ81pIr0yLvtUWk2if982qA3F3QD6H4=",
        version = "v0.0.0-20211012122336-39d0f177ccd0",
    )
    go_repository(
        name = "com_github_lyft_protoc_gen_star",
        build_file_proto_mode = "disable",
        importpath = "github.com/lyft/protoc-gen-star",
        sum = "h1:erE0rdztuaDq3bpGifD95wfoPrSZc95nGA6tbiNYh6M=",
        version = "v0.6.1",
    )
    go_repository(
        name = "com_github_lyft_protoc_gen_star_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/lyft/protoc-gen-star/v2",
        sum = "h1:/3+/2sWyXeMLzKd1bX+ixWKgEMsULrIivpDsuaF441o=",
        version = "v2.0.3",
    )
    go_repository(
        name = "com_github_mailru_easyjson",
        build_file_proto_mode = "disable",
        importpath = "github.com/mailru/easyjson",
        sum = "h1:UGYAvKxe3sBsEDzO8ZeWOSlIQfWFlxbzLZe7hwFURr0=",
        version = "v0.7.7",
    )
    go_repository(
        name = "com_github_mattn_go_colorable",
        build_file_proto_mode = "disable",
        importpath = "github.com/mattn/go-colorable",
        sum = "h1:fFA4WZxdEF4tXPZVKMLwD8oUnCTTo08duU7wxecdEvA=",
        version = "v0.1.13",
    )
    go_repository(
        name = "com_github_mattn_go_isatty",
        build_file_proto_mode = "disable",
        importpath = "github.com/mattn/go-isatty",
        sum = "h1:xfD0iDuEKnDkl03q4limB+vH+GxLEtL/jb4xVJSWWEY=",
        version = "v0.0.20",
    )
    go_repository(
        name = "com_github_mattn_go_runewidth",
        build_file_proto_mode = "disable",
        importpath = "github.com/mattn/go-runewidth",
        sum = "h1:lTGmDsbAYt5DmK6OnoV7EuIF1wEIFAcxld6ypU4OSgU=",
        version = "v0.0.13",
    )
    go_repository(
        name = "com_github_mattn_go_sqlite3",
        build_file_proto_mode = "disable",
        importpath = "github.com/mattn/go-sqlite3",
        sum = "h1:yOQRA0RpS5PFz/oikGwBEqvAWhWg5ufRz4ETLjwpU1Y=",
        version = "v1.14.16",
    )
    go_repository(
        name = "com_github_matttproud_golang_protobuf_extensions",
        build_file_proto_mode = "disable",
        importpath = "github.com/matttproud/golang_protobuf_extensions",
        sum = "h1:mmDVorXM7PCGKw94cs5zkfA9PSy5pEvNWRP0ET0TIVo=",
        version = "v1.0.4",
    )
    go_repository(
        name = "com_github_matttproud_golang_protobuf_extensions_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/matttproud/golang_protobuf_extensions/v2",
        sum = "h1:jWpvCLoY8Z/e3VKvlsiIGKtc+UG6U5vzxaoagmhXfyg=",
        version = "v2.0.0",
    )
    go_repository(
        name = "com_github_mdlayher_socket",
        build_file_proto_mode = "disable",
        importpath = "github.com/mdlayher/socket",
        sum = "h1:eM9y2/jlbs1M615oshPQOHZzj6R6wMT7bX5NPiQvn2U=",
        version = "v0.4.1",
    )
    go_repository(
        name = "com_github_mdlayher_vsock",
        build_file_proto_mode = "disable",
        importpath = "github.com/mdlayher/vsock",
        sum = "h1:pC1mTJTvjo1r9n9fbm7S1j04rCgCzhCOS5DY0zqHlnQ=",
        version = "v1.2.1",
    )
    go_repository(
        name = "com_github_metalmatze_signal",
        build_file_proto_mode = "disable",
        importpath = "github.com/metalmatze/signal",
        sum = "h1:0usWxe5SGXKQovz3p+BiQ81Jy845xSMu2CWKuXsXuUM=",
        version = "v0.0.0-20210307161603-1c9aa721a97a",
    )
    go_repository(
        name = "com_github_mgutz_ansi",
        build_file_proto_mode = "disable",
        importpath = "github.com/mgutz/ansi",
        sum = "h1:j7+1HpAFS1zy5+Q4qx1fWh90gTKwiN4QCGoY9TWyyO4=",
        version = "v0.0.0-20170206155736-9520e82c474b",
    )
    go_repository(
        name = "com_github_microsoft_go_winio",
        build_file_proto_mode = "disable",
        importpath = "github.com/Microsoft/go-winio",
        sum = "h1:9/kr64B9VUZrLm5YYwbGtUJnMgqWVOdUAXu6Migciow=",
        version = "v0.6.1",
    )
    go_repository(
        name = "com_github_miekg_dns",
        build_file_proto_mode = "disable",
        importpath = "github.com/miekg/dns",
        sum = "h1:cN8OuEF1/x5Rq6Np+h1epln8OiyPWV+lROx9LxcGgIQ=",
        version = "v1.1.62",
    )
    go_repository(
        name = "com_github_minio_asm2plan9s",
        build_file_proto_mode = "disable",
        importpath = "github.com/minio/asm2plan9s",
        sum = "h1:AMFGa4R4MiIpspGNG7Z948v4n35fFGB3RR3G/ry4FWs=",
        version = "v0.0.0-20200509001527-cdd76441f9d8",
    )
    go_repository(
        name = "com_github_minio_c2goasm",
        build_file_proto_mode = "disable",
        importpath = "github.com/minio/c2goasm",
        sum = "h1:+n/aFZefKZp7spd8DFdX7uMikMLXX4oubIzJF4kv/wI=",
        version = "v0.0.0-20190812172519-36a3d3bbc4f3",
    )
    go_repository(
        name = "com_github_minio_md5_simd",
        build_file_proto_mode = "disable",
        importpath = "github.com/minio/md5-simd",
        sum = "h1:Gdi1DZK69+ZVMoNHRXJyNcxrMA4dSxoYHZSQbirFg34=",
        version = "v1.1.2",
    )
    go_repository(
        name = "com_github_minio_minio_go_v7",
        build_file_proto_mode = "disable",
        importpath = "github.com/minio/minio-go/v7",
        sum = "h1:2mdUHXEykRdY/BigLt3Iuu1otL0JTogT0Nmltg0wujk=",
        version = "v7.0.80",
    )
    go_repository(
        name = "com_github_minio_sha256_simd",
        build_file_proto_mode = "disable",
        importpath = "github.com/minio/sha256-simd",
        sum = "h1:6kaan5IFmwTNynnKKpDHe6FWHohJOHhCPchzK49dzMM=",
        version = "v1.0.1",
    )
    go_repository(
        name = "com_github_mitchellh_go_homedir",
        build_file_proto_mode = "disable",
        importpath = "github.com/mitchellh/go-homedir",
        sum = "h1:lukF9ziXFxDFPkA1vsr5zpc1XuPDn/wFntq5mG+4E0Y=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_mitchellh_go_ps",
        build_file_proto_mode = "disable",
        importpath = "github.com/mitchellh/go-ps",
        sum = "h1:i6ampVEEF4wQFF+bkYfwYgY+F/uYJDktmvLPf7qIgjc=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_mitchellh_mapstructure",
        build_file_proto_mode = "disable",
        importpath = "github.com/mitchellh/mapstructure",
        sum = "h1:jeMsZIYE/09sWLaz43PL7Gy6RuMjD2eJVyuac5Z2hdY=",
        version = "v1.5.0",
    )
    go_repository(
        name = "com_github_moby_docker_image_spec",
        build_file_proto_mode = "disable",
        importpath = "github.com/moby/docker-image-spec",
        sum = "h1:jMKff3w6PgbfSa69GfNg+zN/XLhfXJGnEx3Nl2EsFP0=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_github_moby_spdystream",
        build_file_proto_mode = "disable",
        importpath = "github.com/moby/spdystream",
        sum = "h1:Vy79D6mHeJJjiPdFEL2yku1kl0chZpJfZcPpb16BRl8=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_moby_term",
        build_file_proto_mode = "disable",
        importpath = "github.com/moby/term",
        sum = "h1:dcztxKSvZ4Id8iPpHERQBbIJfabdt4wUm5qy3wOL2Zc=",
        version = "v0.0.0-20210619224110-3f7ff695adc6",
    )
    go_repository(
        name = "com_github_modern_go_concurrent",
        build_file_proto_mode = "disable",
        importpath = "github.com/modern-go/concurrent",
        sum = "h1:TRLaZ9cD/w8PVh93nsPXa1VrQ6jlwL5oN8l14QlcNfg=",
        version = "v0.0.0-20180306012644-bacd9c7ef1dd",
    )
    go_repository(
        name = "com_github_modern_go_reflect2",
        build_file_proto_mode = "disable",
        importpath = "github.com/modern-go/reflect2",
        sum = "h1:xBagoLtFs94CBntxluKeaWgTMpvLxC4ur3nMaC9Gz0M=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_montanaflynn_stats",
        build_file_proto_mode = "disable",
        importpath = "github.com/montanaflynn/stats",
        sum = "h1:r3y12KyNxj/Sb/iOE46ws+3mS1+MZca1wlHQFPsY/JU=",
        version = "v0.7.0",
    )
    go_repository(
        name = "com_github_morikuni_aec",
        build_file_proto_mode = "disable",
        importpath = "github.com/morikuni/aec",
        sum = "h1:nP9CBfwrvYnBRgY6qfDQkygYDmYwOilePFkwzv4dU8A=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_mozillazg_go_httpheader",
        build_file_proto_mode = "disable",
        importpath = "github.com/mozillazg/go-httpheader",
        sum = "h1:geV7TrjbL8KXSyvghnFm+NyTux/hxwueTSrwhe88TQQ=",
        version = "v0.2.1",
    )
    go_repository(
        name = "com_github_munnerz_goautoneg",
        build_file_proto_mode = "disable",
        importpath = "github.com/munnerz/goautoneg",
        sum = "h1:C3w9PqII01/Oq1c1nUAm88MOHcQC9l5mIlSMApZMrHA=",
        version = "v0.0.0-20191010083416-a7dc8b61c822",
    )
    go_repository(
        name = "com_github_mwitkow_go_conntrack",
        build_file_proto_mode = "disable",
        importpath = "github.com/mwitkow/go-conntrack",
        sum = "h1:KUppIJq7/+SVif2QVs3tOP0zanoHgBEVAwHxUSIzRqU=",
        version = "v0.0.0-20190716064945-2f068394615f",
    )
    go_repository(
        name = "com_github_mxk_go_flowrate",
        build_file_proto_mode = "disable",
        importpath = "github.com/mxk/go-flowrate",
        sum = "h1:y5//uYreIhSUg3J1GEMiLbxo1LJaP8RfCpH6pymGZus=",
        version = "v0.0.0-20140419014527-cca7078d478f",
    )
    go_repository(
        name = "com_github_ncw_swift",
        build_file_proto_mode = "disable",
        importpath = "github.com/ncw/swift",
        sum = "h1:luHjjTNtekIEvHg5KdAFIBaH7bWfNkefwFnpDffSIks=",
        version = "v1.0.53",
    )
    go_repository(
        name = "com_github_niemeyer_pretty",
        build_file_proto_mode = "disable",
        importpath = "github.com/niemeyer/pretty",
        sum = "h1:fD57ERR4JtEqsWbfPhv4DMiApHyliiK5xCTNVSPiaAs=",
        version = "v0.0.0-20200227124842-a10e7caefd8e",
    )
    go_repository(
        name = "com_github_nsf_jsondiff",
        build_file_proto_mode = "disable",
        importpath = "github.com/nsf/jsondiff",
        sum = "h1:dOYG7LS/WK00RWZc8XGgcUTlTxpp3mKhdR2Q9z9HbXM=",
        version = "v0.0.0-20230430225905-43f6cf3098c1",
    )
    go_repository(
        name = "com_github_nxadm_tail",
        build_file_proto_mode = "disable",
        importpath = "github.com/nxadm/tail",
        sum = "h1:nPr65rt6Y5JFSKQO7qToXr7pePgD6Gwiw05lkbyAQTE=",
        version = "v1.4.8",
    )
    go_repository(
        name = "com_github_oklog_run",
        build_file_proto_mode = "disable",
        importpath = "github.com/oklog/run",
        sum = "h1:GEenZ1cK0+q0+wsJew9qUg/DyD8k3JzYsZAi5gYi2mA=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_oklog_ulid",
        build_file_proto_mode = "disable",
        importpath = "github.com/oklog/ulid",
        sum = "h1:EGfNDEx6MqHz8B3uNV6QAib1UR2Lm97sHi3ocA6ESJ4=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_github_olekukonko_tablewriter",
        build_file_proto_mode = "disable",
        importpath = "github.com/olekukonko/tablewriter",
        sum = "h1:P2Ga83D34wi1o9J6Wh1mRuqd4mF/x/lgBS7N7AbDhec=",
        version = "v0.0.5",
    )
    go_repository(
        name = "com_github_oneofone_xxhash",
        build_file_proto_mode = "disable",
        importpath = "github.com/OneOfOne/xxhash",
        sum = "h1:U68crOE3y3MPttCMQGywZOLrTeF5HHJ3/vDBCJn9/bA=",
        version = "v1.2.6",
    )
    go_repository(
        name = "com_github_onsi_ginkgo",
        build_file_proto_mode = "disable",
        importpath = "github.com/onsi/ginkgo",
        sum = "h1:8xi0RTUf59SOSfEtZMvwTvXYMzG4gV23XVHOZiXNtnE=",
        version = "v1.16.5",
    )
    go_repository(
        name = "com_github_onsi_ginkgo_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/onsi/ginkgo/v2",
        sum = "h1:9Cnnf7UHo57Hy3k6/m5k3dRfGTMXGvxhHFvkDTCTpvA=",
        version = "v2.19.0",
    )
    go_repository(
        name = "com_github_onsi_gomega",
        build_file_proto_mode = "disable",
        importpath = "github.com/onsi/gomega",
        sum = "h1:eSSPsPNp6ZpsG8X1OVmOTxig+CblTc4AxpPBykhe2Os=",
        version = "v1.34.0",
    )
    go_repository(
        name = "com_github_opencontainers_go_digest",
        build_file_proto_mode = "disable",
        importpath = "github.com/opencontainers/go-digest",
        sum = "h1:apOUWs51W5PlhuyGyz9FCeeBIOUDA/6nW8Oi/yOhh5U=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_opencontainers_image_spec",
        build_file_proto_mode = "disable",
        importpath = "github.com/opencontainers/image-spec",
        sum = "h1:9yCKha/T5XdGtO0q9Q9a6T5NUCsTn/DrBg0D7ufOcFM=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_opencontainers_runtime_spec",
        build_file_proto_mode = "disable",
        importpath = "github.com/opencontainers/runtime-spec",
        sum = "h1:UfAcuLBJB9Coz72x1hgl8O5RVzTdNiaglX6v2DM6FI0=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_opentracing_basictracer_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/opentracing/basictracer-go",
        sum = "h1:Oa1fTSBvAl8pa3U+IJYqrKm0NALwH9OsgwOqDv4xJW0=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_opentracing_contrib_go_grpc",
        build_file_proto_mode = "disable",
        importpath = "github.com/opentracing-contrib/go-grpc",
        sum = "h1:4cPxUYdgaGzZIT5/j0IfqOrrXmq6bG8AwvwisMXpdrg=",
        version = "v0.0.0-20210225150812-73cb765af46e",
    )
    go_repository(
        name = "com_github_opentracing_contrib_go_stdlib",
        build_file_proto_mode = "disable",
        importpath = "github.com/opentracing-contrib/go-stdlib",
        sum = "h1:TBS7YuVotp8myLon4Pv7BtCBzOTo1DeZCld0Z63mW2w=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_opentracing_opentracing_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/opentracing/opentracing-go",
        sum = "h1:uEJPy/1a5RIPAJ0Ov+OIO8OxWu77jEv+1B0VhjKrZUs=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_oracle_oci_go_sdk_v65",
        build_file_proto_mode = "disable",
        importpath = "github.com/oracle/oci-go-sdk/v65",
        sum = "h1:+lbosOyNiib3TGJDvLq1HwEAuFqkOjPJDIkyxM15WdQ=",
        version = "v65.41.1",
    )
    go_repository(
        name = "com_github_orisano_pixelmatch",
        build_file_proto_mode = "disable",
        importpath = "github.com/orisano/pixelmatch",
        sum = "h1:x0TT0RDC7UhAVbbWWBzr41ElhJx5tXPWkIHA2HWPRuw=",
        version = "v0.0.0-20220722002657-fb0b55479cde",
    )
    go_repository(
        name = "com_github_ovh_go_ovh",
        build_file_proto_mode = "disable",
        importpath = "github.com/ovh/go-ovh",
        sum = "h1:ixLOwxQdzYDx296sXcgS35TOPEahJkpjMGtzPadCjQI=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_github_pbnjay_memory",
        build_file_proto_mode = "disable",
        importpath = "github.com/pbnjay/memory",
        sum = "h1:onHthvaw9LFnH4t2DcNVpwGmV9E1BkGknEliJkfwQj0=",
        version = "v0.0.0-20210728143218-7b4eea64cf58",
    )
    go_repository(
        name = "com_github_peterbourgon_diskv",
        build_file_proto_mode = "disable",
        importpath = "github.com/peterbourgon/diskv",
        sum = "h1:UBdAOUP5p4RWqPBg048CAvpKN+vxiaj6gdUUzhl4XmI=",
        version = "v2.0.1+incompatible",
    )
    go_repository(
        name = "com_github_philhofer_fwd",
        build_file_proto_mode = "disable",
        importpath = "github.com/philhofer/fwd",
        sum = "h1:GdGcTjf5RNAxwS4QLsiMzJYj5KEvPJD3Abr261yRQXQ=",
        version = "v1.1.1",
    )
    go_repository(
        name = "com_github_phpdave11_gofpdf",
        build_file_proto_mode = "disable",
        importpath = "github.com/phpdave11/gofpdf",
        sum = "h1:KPKiIbfwbvC/wOncwhrpRdXVj2CZTCFlw4wnoyjtHfQ=",
        version = "v1.4.2",
    )
    go_repository(
        name = "com_github_phpdave11_gofpdi",
        build_file_proto_mode = "disable",
        importpath = "github.com/phpdave11/gofpdi",
        sum = "h1:o61duiW8M9sMlkVXWlvP92sZJtGKENvW3VExs6dZukQ=",
        version = "v1.0.13",
    )
    go_repository(
        name = "com_github_pierrec_lz4_v4",
        build_file_proto_mode = "disable",
        importpath = "github.com/pierrec/lz4/v4",
        sum = "h1:xaKrnTkyoqfh1YItXl56+6KJNVYWlEEPuAQW9xsplYQ=",
        version = "v4.1.18",
    )
    go_repository(
        name = "com_github_pkg_browser",
        build_file_proto_mode = "disable",
        importpath = "github.com/pkg/browser",
        sum = "h1:+mdjkGKdHQG3305AYmdv1U2eRNDiU2ErMBj1gwrq8eQ=",
        version = "v0.0.0-20240102092130-5ac0b6a4141c",
    )
    go_repository(
        name = "com_github_pkg_diff",
        build_file_proto_mode = "disable",
        importpath = "github.com/pkg/diff",
        sum = "h1:aoZm08cpOy4WuID//EZDgcC4zIxODThtZNPirFr42+A=",
        version = "v0.0.0-20210226163009-20ebb0f2a09e",
    )
    go_repository(
        name = "com_github_pkg_errors",
        build_file_proto_mode = "disable",
        importpath = "github.com/pkg/errors",
        sum = "h1:FEBLx1zS214owpjy7qsBeixbURkuhQAwrK5UwLGTwt4=",
        version = "v0.9.1",
    )
    go_repository(
        name = "com_github_pkg_sftp",
        build_file_proto_mode = "disable",
        importpath = "github.com/pkg/sftp",
        sum = "h1:I2qBYMChEhIjOgazfJmV3/mZM256btk6wkCDRmW7JYs=",
        version = "v1.13.1",
    )
    go_repository(
        name = "com_github_planetscale_vtprotobuf",
        build_file_proto_mode = "disable",
        importpath = "github.com/planetscale/vtprotobuf",
        sum = "h1:GFCKgmp0tecUJ0sJuv4pzYCqS9+RGSn52M3FUwPs+uo=",
        version = "v0.6.1-0.20240319094008-0393e58bdf10",
    )
    go_repository(
        name = "com_github_pmezard_go_difflib",
        build_file_proto_mode = "disable",
        importpath = "github.com/pmezard/go-difflib",
        sum = "h1:Jamvg5psRIccs7FGNTlIRMkT8wgtp5eCXdBlqhYGL6U=",
        version = "v1.0.1-0.20181226105442-5d4384ee4fb2",
    )
    go_repository(
        name = "com_github_power_devops_perfstat",
        build_file_proto_mode = "disable",
        importpath = "github.com/power-devops/perfstat",
        sum = "h1:ncq/mPwQF4JjgDlrVEn3C11VoGHZN7m8qihwgMEtzYw=",
        version = "v0.0.0-20210106213030-5aafc221ea8c",
    )
    go_repository(
        name = "com_github_prashantv_gostub",
        build_file_proto_mode = "disable",
        importpath = "github.com/prashantv/gostub",
        sum = "h1:BTyx3RfQjRHnUWaGF9oQos79AlQ5k8WNktv7VGvVH4g=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_prometheus_alertmanager",
        build_file_proto_mode = "disable",
        importpath = "github.com/prometheus/alertmanager",
        sum = "h1:V6nTa2J5V4s8TG4C4HtrBP/WNSebCCTYGGv4qecA/+I=",
        version = "v0.27.0",
    )
    go_repository(
        name = "com_github_prometheus_client_golang",
        build_file_proto_mode = "disable",
        importpath = "github.com/prometheus/client_golang",
        sum = "h1:cxppBPuYhUnsO6yo/aoRol4L7q7UFfdm+bR9r+8l63Y=",
        version = "v1.20.5",
    )
    go_repository(
        name = "com_github_prometheus_client_model",
        build_file_proto_mode = "disable",
        importpath = "github.com/prometheus/client_model",
        sum = "h1:ZKSh/rekM+n3CeS952MLRAdFwIKqeY8b62p8ais2e9E=",
        version = "v0.6.1",
    )
    go_repository(
        name = "com_github_prometheus_common",
        build_file_proto_mode = "disable",
        importpath = "github.com/prometheus/common",
        sum = "h1:+V9PAREWNvJMAuJ1x1BaWl9dewMW4YrHZQbx0sJNllA=",
        version = "v0.60.0",
    )
    go_repository(
        name = "com_github_prometheus_common_assets",
        build_file_proto_mode = "disable",
        importpath = "github.com/prometheus/common/assets",
        sum = "h1:0P5OrzoHrYBOSM1OigWL3mY8ZvV2N4zIE/5AahrSrfM=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_prometheus_common_sigv4",
        build_file_proto_mode = "disable",
        importpath = "github.com/prometheus/common/sigv4",
        sum = "h1:qoVebwtwwEhS85Czm2dSROY5fTo2PAPEVdDeppTwGX4=",
        version = "v0.1.0",
    )
    go_repository(
        name = "com_github_prometheus_community_prom_label_proxy",
        build_file_proto_mode = "disable",
        importpath = "github.com/prometheus-community/prom-label-proxy",
        sum = "h1:owfYHh79h8Y5HvNMGyww+DaVwo10CKiRW1RQrrZzIwg=",
        version = "v0.8.1-0.20240127162815-c1195f9aabc0",
    )
    go_repository(
        name = "com_github_prometheus_exporter_toolkit",
        build_file_proto_mode = "disable",
        importpath = "github.com/prometheus/exporter-toolkit",
        sum = "h1:DkE5RcEZR3lQA2QD5JLVQIf41dFKNsVMXFhgqcif7fo=",
        version = "v0.12.0",
    )
    go_repository(
        name = "com_github_prometheus_procfs",
        build_file_proto_mode = "disable",
        importpath = "github.com/prometheus/procfs",
        sum = "h1:YagwOFzUgYfKKHX6Dr+sHT7km/hxC76UB0learggepc=",
        version = "v0.15.1",
    )
    go_repository(
        name = "com_github_prometheus_prometheus",
        build_file_proto_mode = "disable",
        importpath = "github.com/prometheus/prometheus",
        sum = "h1:hCxAh6+hxwy7dqUPE5ndnilMeCWrqQkJVjPDXtiYRVo=",
        version = "v0.55.1-0.20241102120812-a6fd22b9d2c8",
    )
    go_repository(
        name = "com_github_qcloudapi_qcloud_sign_golang",
        build_file_proto_mode = "disable",
        importpath = "github.com/QcloudApi/qcloud_sign_golang",
        sum = "h1:DTQ/38ao/CfXsrK0cSAL+h4R/u0VVvfWLZEOlLwEROI=",
        version = "v0.0.0-20141224014652-e4130a326409",
    )
    go_repository(
        name = "com_github_redis_rueidis",
        build_file_proto_mode = "disable",
        importpath = "github.com/redis/rueidis",
        sum = "h1:69Bu1l7gVC/qDYuGGwMwGg2rjOjSyxESol/Zila62gY=",
        version = "v1.0.45-alpha.1",
    )
    go_repository(
        name = "com_github_remyoudompheng_bigfft",
        build_file_proto_mode = "disable",
        importpath = "github.com/remyoudompheng/bigfft",
        sum = "h1:W09IVJc94icq4NjY3clb7Lk8O1qJ8BdBEF8z0ibU0rE=",
        version = "v0.0.0-20230129092748-24d4a6f8daec",
    )
    go_repository(
        name = "com_github_rivo_uniseg",
        build_file_proto_mode = "disable",
        importpath = "github.com/rivo/uniseg",
        sum = "h1:S1pD9weZBuJdFmowNwbpi7BJ8TNftyUImj/0WQi72jY=",
        version = "v0.2.0",
    )
    go_repository(
        name = "com_github_rogpeppe_fastuuid",
        build_file_proto_mode = "disable",
        importpath = "github.com/rogpeppe/fastuuid",
        sum = "h1:Ppwyp6VYCF1nvBTXL3trRso7mXMlRrw9ooo375wvi2s=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_rogpeppe_go_internal",
        build_file_proto_mode = "disable",
        importpath = "github.com/rogpeppe/go-internal",
        sum = "h1:exVL4IDcn6na9z1rAb56Vxr+CgyK3nn3O+epU5NdKM8=",
        version = "v1.12.0",
    )
    go_repository(
        name = "com_github_rs_cors",
        build_file_proto_mode = "disable",
        importpath = "github.com/rs/cors",
        sum = "h1:L0uuZVXIKlI1SShY2nhFfo44TYvDPQ1w4oFkUJNfhyo=",
        version = "v1.10.1",
    )
    go_repository(
        name = "com_github_rs_xid",
        build_file_proto_mode = "disable",
        importpath = "github.com/rs/xid",
        sum = "h1:fV591PaemRlL6JfRxGDEPl69wICngIQ3shQtzfy2gxU=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_github_ruudk_golang_pdf417",
        build_file_proto_mode = "disable",
        importpath = "github.com/ruudk/golang-pdf417",
        sum = "h1:K1Xf3bKttbF+koVGaX5xngRIZ5bVjbmPnaxE/dR08uY=",
        version = "v0.0.0-20201230142125-a7e3863a1245",
    )
    go_repository(
        name = "com_github_santhosh_tekuri_jsonschema",
        build_file_proto_mode = "disable",
        importpath = "github.com/santhosh-tekuri/jsonschema",
        sum = "h1:hNhW8e7t+H1vgY+1QeEQpveR6D4+OwKPXCfD2aieJis=",
        version = "v1.2.4",
    )
    go_repository(
        name = "com_github_satori_go_uuid",
        build_file_proto_mode = "disable",
        importpath = "github.com/satori/go.uuid",
        sum = "h1:gQZ0qzfKHQIybLANtM3mBXNUtOfsCFXeTsnBqCsx1KM=",
        version = "v1.2.1-0.20181028125025-b2ce2384e17b",
    )
    go_repository(
        name = "com_github_scaleway_scaleway_sdk_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/scaleway/scaleway-sdk-go",
        sum = "h1:yoKAVkEVwAqbGbR8n87rHQ1dulL25rKloGadb3vm770=",
        version = "v1.0.0-beta.30",
    )
    go_repository(
        name = "com_github_sean_seed",
        build_file_proto_mode = "disable",
        importpath = "github.com/sean-/seed",
        sum = "h1:nn5Wsu0esKSJiIVhscUtVbo7ada43DJhG55ua/hjS5I=",
        version = "v0.0.0-20170313163322-e2103e2c3529",
    )
    go_repository(
        name = "com_github_seiflotfy_cuckoofilter",
        build_file_proto_mode = "disable",
        importpath = "github.com/seiflotfy/cuckoofilter",
        sum = "h1:emzAzMZ1L9iaKCTxdy3Em8Wv4ChIAGnfiz18Cda70g4=",
        version = "v0.0.0-20240715131351-a2f2c23f1771",
    )
    go_repository(
        name = "com_github_sercand_kuberesolver_v4",
        build_file_proto_mode = "disable",
        importpath = "github.com/sercand/kuberesolver/v4",
        replace = "github.com/sercand/kuberesolver/v5",
        sum = "h1:CYH+d67G0sGBj7q5wLK61yzqJJ8gLLC8aeprPTHb6yY=",
        version = "v5.1.1",
    )
    go_repository(
        name = "com_github_shirou_gopsutil_v3",
        build_file_proto_mode = "disable",
        importpath = "github.com/shirou/gopsutil/v3",
        sum = "h1:yibtJhIVEMcdw+tCTbOPiF1VcsuDeTE4utJ8Dm4c5eA=",
        version = "v3.22.9",
    )
    go_repository(
        name = "com_github_shurcool_httpfs",
        build_file_proto_mode = "disable",
        importpath = "github.com/shurcooL/httpfs",
        sum = "h1:aqg5Vm5dwtvL+YgDpBcK1ITf3o96N/K7/wsRXQnUTEs=",
        version = "v0.0.0-20230704072500-f1e31cf0ba5c",
    )
    go_repository(
        name = "com_github_shurcool_vfsgen",
        build_file_proto_mode = "disable",
        importpath = "github.com/shurcooL/vfsgen",
        sum = "h1:pXY9qYc/MP5zdvqWEUH6SjNiu7VhSjuVFTFiTcphaLU=",
        version = "v0.0.0-20200824052919-0d455de96546",
    )
    go_repository(
        name = "com_github_sirupsen_logrus",
        build_file_proto_mode = "disable",
        importpath = "github.com/sirupsen/logrus",
        sum = "h1:dueUQJ1C2q9oE3F7wvmSGAaVtTmUizReu6fjN8uqzbQ=",
        version = "v1.9.3",
    )
    go_repository(
        name = "com_github_soheilhy_cmux",
        build_file_proto_mode = "disable",
        importpath = "github.com/soheilhy/cmux",
        sum = "h1:jjzc5WVemNEDTLwv9tlmemhC73tI08BNOIGwBOo10Js=",
        version = "v0.1.5",
    )
    go_repository(
        name = "com_github_sony_gobreaker",
        build_file_proto_mode = "disable",
        importpath = "github.com/sony/gobreaker",
        sum = "h1:dRCvqm0P490vZPmy7ppEk2qCnCieBooFJ+YoXGYB+yg=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_github_spaolacci_murmur3",
        build_file_proto_mode = "disable",
        importpath = "github.com/spaolacci/murmur3",
        sum = "h1:7c1g84S4BPRrfL5Xrdp6fOJ206sU9y293DDHaoy0bLI=",
        version = "v1.1.0",
    )
    go_repository(
        name = "com_github_spf13_afero",
        build_file_proto_mode = "disable",
        importpath = "github.com/spf13/afero",
        sum = "h1:EaGW2JJh15aKOejeuJ+wpFSHnbd7GE6Wvp3TsNhb6LY=",
        version = "v1.10.0",
    )
    go_repository(
        name = "com_github_spf13_pflag",
        build_file_proto_mode = "disable",
        importpath = "github.com/spf13/pflag",
        sum = "h1:iy+VFUOCP1a+8yFto/drg2CJ5u0yRoB7fZw3DKv/JXA=",
        version = "v1.0.5",
    )
    go_repository(
        name = "com_github_stackexchange_wmi",
        build_file_proto_mode = "disable",
        importpath = "github.com/StackExchange/wmi",
        sum = "h1:G0m3OIz70MZUWq3EgK3CesDbo8upS2Vm9/P3FtgI+Jk=",
        version = "v0.0.0-20190523213315-cbe66965904d",
    )
    go_repository(
        name = "com_github_stoewer_go_strcase",
        build_file_proto_mode = "disable",
        importpath = "github.com/stoewer/go-strcase",
        sum = "h1:g0eASXYtp+yvN9fK8sH94oCIk0fau9uV1/ZdJ0AVEzs=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_stretchr_objx",
        build_file_proto_mode = "disable",
        importpath = "github.com/stretchr/objx",
        sum = "h1:xuMeJ0Sdp5ZMRXx/aWO6RZxdr3beISkG5/G/aIRr3pY=",
        version = "v0.5.2",
    )
    go_repository(
        name = "com_github_stretchr_testify",
        build_file_proto_mode = "disable",
        importpath = "github.com/stretchr/testify",
        sum = "h1:HtqpIVDClZ4nwg75+f6Lvsy/wHu+3BoSGCbBAcpTsTg=",
        version = "v1.9.0",
    )
    go_repository(
        name = "com_github_substrait_io_substrait_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/substrait-io/substrait-go",
        sum = "h1:buDnjsb3qAqTaNbOR7VKmNgXf4lYQxWEcnSGUWBtmN8=",
        version = "v0.4.2",
    )
    go_repository(
        name = "com_github_tencentcloud_tencentcloud_sdk_go_tencentcloud_common",
        build_file_proto_mode = "disable",
        importpath = "github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/common",
        sum = "h1:Oho9ykiKXwOHkeq5jSAvlkBAcRwNqnrUca/5WacvH2E=",
        version = "v1.0.194",
    )
    go_repository(
        name = "com_github_tencentcloud_tencentcloud_sdk_go_tencentcloud_kms",
        build_file_proto_mode = "disable",
        importpath = "github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/kms",
        sum = "h1:YB6qJyCPuwtHFr54/GAfYj1VfwhiDHnwtOKu40OaG2M=",
        version = "v1.0.194",
    )
    go_repository(
        name = "com_github_tencentyun_cos_go_sdk_v5",
        build_file_proto_mode = "disable",
        importpath = "github.com/tencentyun/cos-go-sdk-v5",
        sum = "h1:W6vDGKCHe4wBACI1d2UgE6+50sJFhRWU4O8IB2ozzxM=",
        version = "v0.7.40",
    )
    go_repository(
        name = "com_github_thanos_io_objstore",
        build_file_proto_mode = "disable",
        importpath = "github.com/thanos-io/objstore",
        patch_args = ["-p1"],
        patches = [
            "//patches:0001-skybroker-s3-patch.patch",
            "//patches:0002-SkyBroker-AWS-S3-patch.patch",
            "//patches:0003-Limit-pool-and-randomize-selection.patch",
            "//patches:0004-Changed-connections.patch",
        ],
        sum = "h1:VjG0mwhN1DkncwDHFvrpd12/2TLfgYNRmEQA48ikp+0=",
        version = "v0.0.0-20241111205755-d1dd89d41f97",
    )
    go_repository(
        name = "com_github_thanos_io_promql_engine",
        build_file_proto_mode = "disable",
        importpath = "github.com/thanos-io/promql-engine",
        sum = "h1:cChM/FbpXeYmrSmXO1/MmmSlONviLVxWAWCB0/g4JrY=",
        version = "v0.0.0-20241203103240-2f49f80c7c68",
    )
    go_repository(
        name = "com_github_tinylib_msgp",
        build_file_proto_mode = "disable",
        importpath = "github.com/tinylib/msgp",
        sum = "h1:2gXmtWueD2HefZHQe1QOy9HVzmFrLOVvsXwXBQ0ayy0=",
        version = "v1.1.5",
    )
    go_repository(
        name = "com_github_tj_assert",
        build_file_proto_mode = "disable",
        importpath = "github.com/tj/assert",
        sum = "h1:Df/BlaZ20mq6kuai7f5z2TvPFiwC3xaWJSDQNiIS3Rk=",
        version = "v0.0.3",
    )
    go_repository(
        name = "com_github_tklauser_go_sysconf",
        build_file_proto_mode = "disable",
        importpath = "github.com/tklauser/go-sysconf",
        sum = "h1:IJ1AZGZRWbY8T5Vfk04D9WOA5WSejdflXxP03OUqALw=",
        version = "v0.3.10",
    )
    go_repository(
        name = "com_github_tklauser_numcpus",
        build_file_proto_mode = "disable",
        importpath = "github.com/tklauser/numcpus",
        sum = "h1:E53Dm1HjH1/R2/aoCtXtPgzmElmn51aOkhCFSuZq//o=",
        version = "v0.4.0",
    )
    go_repository(
        name = "com_github_uber_jaeger_client_go",
        build_file_proto_mode = "disable",
        importpath = "github.com/uber/jaeger-client-go",
        sum = "h1:D6wyKGCecFaSRUpo8lCVbaOOb6ThwMmTEbhRwtKR97o=",
        version = "v2.30.0+incompatible",
    )
    go_repository(
        name = "com_github_uber_jaeger_lib",
        build_file_proto_mode = "disable",
        importpath = "github.com/uber/jaeger-lib",
        sum = "h1:td4jdvLcExb4cBISKIpHuGoVXh+dVKhn2Um6rjCsSsg=",
        version = "v2.4.1+incompatible",
    )
    go_repository(
        name = "com_github_vimeo_galaxycache",
        build_file_proto_mode = "disable",
        importpath = "github.com/vimeo/galaxycache",
        replace = "github.com/thanos-community/galaxycache",
        sum = "h1:f1Zsv7OAU9iQhZwigp50Yl38W10g/vd5NC8Rdk1Jzng=",
        version = "v0.0.0-20211122094458-3a32041a1f1e",
    )
    go_repository(
        name = "com_github_vultr_govultr_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/vultr/govultr/v2",
        sum = "h1:gej/rwr91Puc/tgh+j33p/BLR16UrIPnSr+AIwYWZQs=",
        version = "v2.17.2",
    )
    go_repository(
        name = "com_github_weaveworks_common",
        build_file_proto_mode = "disable",
        importpath = "github.com/weaveworks/common",
        sum = "h1:nORobjToZAvi54wcuUXLq+XG2Rsr0XEizy5aHBHvqWQ=",
        version = "v0.0.0-20230728070032-dd9e68f319d5",
    )
    go_repository(
        name = "com_github_weaveworks_promrus",
        build_file_proto_mode = "disable",
        importpath = "github.com/weaveworks/promrus",
        sum = "h1:jOLf6pe6/vss4qGHjXmGz4oDJQA+AOCqEL3FvvZGz7M=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_x448_float16",
        build_file_proto_mode = "disable",
        importpath = "github.com/x448/float16",
        sum = "h1:qLwI1I70+NjRFUR3zs1JPUCgaCXSh3SW62uAKT1mSBM=",
        version = "v0.8.4",
    )
    go_repository(
        name = "com_github_xdg_go_pbkdf2",
        build_file_proto_mode = "disable",
        importpath = "github.com/xdg-go/pbkdf2",
        sum = "h1:Su7DPu48wXMwC3bs7MCNG+z4FhcyEuz5dlvchbq0B0c=",
        version = "v1.0.0",
    )
    go_repository(
        name = "com_github_xdg_go_scram",
        build_file_proto_mode = "disable",
        importpath = "github.com/xdg-go/scram",
        sum = "h1:FHX5I5B4i4hKRVRBCFRxq1iQRej7WO3hhBuJf+UUySY=",
        version = "v1.1.2",
    )
    go_repository(
        name = "com_github_xdg_go_stringprep",
        build_file_proto_mode = "disable",
        importpath = "github.com/xdg-go/stringprep",
        sum = "h1:XLI/Ng3O1Atzq0oBs3TWm+5ZVgkq2aqdlvP9JtoZ6c8=",
        version = "v1.0.4",
    )
    go_repository(
        name = "com_github_xhit_go_str2duration",
        build_file_proto_mode = "disable",
        importpath = "github.com/xhit/go-str2duration",
        sum = "h1:BcV5u025cITWxEQKGWr1URRzrcXtu7uk8+luz3Yuhwc=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_xhit_go_str2duration_v2",
        build_file_proto_mode = "disable",
        importpath = "github.com/xhit/go-str2duration/v2",
        sum = "h1:lxklc02Drh6ynqX+DdPyp5pCKLUQpRT8bp8Ydu2Bstc=",
        version = "v2.1.0",
    )
    go_repository(
        name = "com_github_xlab_treeprint",
        build_file_proto_mode = "disable",
        importpath = "github.com/xlab/treeprint",
        sum = "h1:HzHnuAF1plUN2zGlAFHbSQP2qJ0ZAD3XF5XD7OesXRQ=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_github_youmark_pkcs8",
        build_file_proto_mode = "disable",
        importpath = "github.com/youmark/pkcs8",
        sum = "h1:splanxYIlg+5LfHAM6xpdFEAYOk8iySO56hMFq6uLyA=",
        version = "v0.0.0-20181117223130-1be2e3e5546d",
    )
    go_repository(
        name = "com_github_yuin_goldmark",
        build_file_proto_mode = "disable",
        importpath = "github.com/yuin/goldmark",
        sum = "h1:fVcFKWvrslecOb/tg+Cc05dkeYx540o0FuFt3nUVDoE=",
        version = "v1.4.13",
    )
    go_repository(
        name = "com_github_yuin_gopher_lua",
        build_file_proto_mode = "disable",
        importpath = "github.com/yuin/gopher-lua",
        sum = "h1:k/gmLsJDWwWqbLCur2yWnJzwQEKRcAHXo6seXGuSwWw=",
        version = "v0.0.0-20210529063254-f4c35e4016d9",
    )
    go_repository(
        name = "com_github_yusufpapurcu_wmi",
        build_file_proto_mode = "disable",
        importpath = "github.com/yusufpapurcu/wmi",
        sum = "h1:KBNDSne4vP5mbSWnJbO+51IMOXJB67QiYCSBrubbPRg=",
        version = "v1.2.2",
    )
    go_repository(
        name = "com_github_zeebo_assert",
        build_file_proto_mode = "disable",
        importpath = "github.com/zeebo/assert",
        sum = "h1:g7C04CbJuIDKNPFHmsk4hwZDO5O+kntRxzaUoNXj+IQ=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_github_zeebo_xxh3",
        build_file_proto_mode = "disable",
        importpath = "github.com/zeebo/xxh3",
        sum = "h1:xZmwmqxHZA8AI603jOQ0tMqmBr9lPeFwGg6d+xy9DC0=",
        version = "v1.0.2",
    )
    go_repository(
        name = "com_github_zhangyunhao116_umap",
        build_file_proto_mode = "disable",
        importpath = "github.com/zhangyunhao116/umap",
        sum = "h1:D3ltj0b2c2FgUacKrB1pWGgwrUyCESY9W8XYYQ5sqY8=",
        version = "v0.0.0-20221211160557-cb7705fafa39",
    )
    go_repository(
        name = "com_google_cloud_go",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go",
        sum = "h1:Jo0SM9cQnSkYfp44+v+NQXHpcHqlnRJk2qxh6yvxxxQ=",
        version = "v0.115.1",
    )
    go_repository(
        name = "com_google_cloud_go_accessapproval",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/accessapproval",
        sum = "h1:uxJBvDCor5iuCYOVby/0WTsHSMyBh8bpJ6hzqKdcL64=",
        version = "v1.7.12",
    )
    go_repository(
        name = "com_google_cloud_go_accesscontextmanager",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/accesscontextmanager",
        sum = "h1:u3gLVJFZ8couGeVBZmhK0ON5YU3w9YIXOVr+THOik/M=",
        version = "v1.8.12",
    )
    go_repository(
        name = "com_google_cloud_go_aiplatform",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/aiplatform",
        sum = "h1:EPPqgHDJpBZKRvv+OsB3cr0jYz3EL2pZ+802rBPcG8U=",
        version = "v1.68.0",
    )
    go_repository(
        name = "com_google_cloud_go_analytics",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/analytics",
        sum = "h1:wIMRXRQAanMWaUGSOglVwEmpZqCC4WAs9YacMuGcD88=",
        version = "v0.24.0",
    )
    go_repository(
        name = "com_google_cloud_go_apigateway",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/apigateway",
        sum = "h1:yynQNoSDVxbc8iPA2kLC4RWj1Ir64/FhGcXbyhJKC4c=",
        version = "v1.6.12",
    )
    go_repository(
        name = "com_google_cloud_go_apigeeconnect",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/apigeeconnect",
        sum = "h1:Pq2wTmm41l2w5sLuxEGRZmXhYULKg5qIWcvGEOsFhZQ=",
        version = "v1.6.12",
    )
    go_repository(
        name = "com_google_cloud_go_apigeeregistry",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/apigeeregistry",
        sum = "h1:DYqJWmGXIfPWnvSER1eIrMvCpzpPaWyfwUbZ9n51tR0=",
        version = "v0.8.10",
    )
    go_repository(
        name = "com_google_cloud_go_apikeys",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/apikeys",
        sum = "h1:B9CdHFZTFjVti89tmyXXrO+7vSNo2jvZuHG8zD5trdQ=",
        version = "v0.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_appengine",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/appengine",
        sum = "h1:R4n+yN8pyOZQmufa5NlvPKLnG4C0YIAgYUmKLHN7Xgg=",
        version = "v1.8.12",
    )
    go_repository(
        name = "com_google_cloud_go_area120",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/area120",
        sum = "h1:MIAp/4z3v6RVmdhBy20xL3q2eFCpMRSk9gQqxwppu44=",
        version = "v0.8.12",
    )
    go_repository(
        name = "com_google_cloud_go_artifactregistry",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/artifactregistry",
        sum = "h1:RADsnxebM3WPtZrvWx2PYGWWxyqEsbe3rTTDRad6cZM=",
        version = "v1.14.14",
    )
    go_repository(
        name = "com_google_cloud_go_asset",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/asset",
        sum = "h1:p8Huo2TW4GyTfqQZuvUsmvYc3bXC1uS51VvpKfPfqqU=",
        version = "v1.19.6",
    )
    go_repository(
        name = "com_google_cloud_go_assuredworkloads",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/assuredworkloads",
        sum = "h1:Oh8gYugn66aqjxlCEJq7WMEo7W8RR12mPK0B2FFfhL4=",
        version = "v1.11.12",
    )
    go_repository(
        name = "com_google_cloud_go_auth",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/auth",
        sum = "h1:VOEUIAADkkLtyfr3BLa3R8Ed/j6w1jTBmARx+wb5w5U=",
        version = "v0.9.3",
    )
    go_repository(
        name = "com_google_cloud_go_auth_oauth2adapt",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/auth/oauth2adapt",
        sum = "h1:0GWE/FUsXhf6C+jAkWgYm7X9tK8cuEIfy19DBn6B6bY=",
        version = "v0.2.4",
    )
    go_repository(
        name = "com_google_cloud_go_automl",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/automl",
        sum = "h1:sjA6i5RbSqtgVzlLStZN3++AHKbZaCCvBmt68NeAAS0=",
        version = "v1.13.12",
    )
    go_repository(
        name = "com_google_cloud_go_baremetalsolution",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/baremetalsolution",
        sum = "h1:rhMIixzQvm9cy8Ks3etB/JQOMw5vU8z71Jqf7VwI1Ts=",
        version = "v1.2.11",
    )
    go_repository(
        name = "com_google_cloud_go_batch",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/batch",
        sum = "h1:JQWzsdmjnONvqNWeAubtDI6OIFv/v2lCYGzx8lpxTKg=",
        version = "v1.9.4",
    )
    go_repository(
        name = "com_google_cloud_go_beyondcorp",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/beyondcorp",
        sum = "h1:oBXJtKP2J7VLqYQf6l5i2Cqm/qjFJPngnGKbzehkxYU=",
        version = "v1.0.11",
    )
    go_repository(
        name = "com_google_cloud_go_bigquery",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/bigquery",
        sum = "h1:SYEA2f7fKqbSRRBHb7g0iHTtZvtPSPYdXfmqsjpsBwo=",
        version = "v1.62.0",
    )
    go_repository(
        name = "com_google_cloud_go_bigtable",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/bigtable",
        sum = "h1:2CnFjKPwjpZMZdTi2RpppvxzD80zKzDYrLYEQw/NnAs=",
        version = "v1.29.0",
    )
    go_repository(
        name = "com_google_cloud_go_billing",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/billing",
        sum = "h1:Hguzxohg+0U/qMFmB0hyK/rM1yH1VSARMgZ8fM1K5as=",
        version = "v1.18.10",
    )
    go_repository(
        name = "com_google_cloud_go_binaryauthorization",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/binaryauthorization",
        sum = "h1:Gxcy5/ydfTg2CviIxnZPVCNcFoDmQRbjzfAKg8bDJAU=",
        version = "v1.8.8",
    )
    go_repository(
        name = "com_google_cloud_go_certificatemanager",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/certificatemanager",
        sum = "h1:ekHCSJWJ8NFWvCRLRRWrJh1iPeJAKx0oIq0i9gFyVRM=",
        version = "v1.8.6",
    )
    go_repository(
        name = "com_google_cloud_go_channel",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/channel",
        sum = "h1:JNtAUfwGEOgeBp1bOxSzY/Hi3H1ARySNrj5cNBmOG+M=",
        version = "v1.17.12",
    )
    go_repository(
        name = "com_google_cloud_go_cloudbuild",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/cloudbuild",
        sum = "h1:6kV/JpCSKq64KWuZMYWZ8/utSkifWfEtQ+EcPjWPPLs=",
        version = "v1.16.6",
    )
    go_repository(
        name = "com_google_cloud_go_clouddms",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/clouddms",
        sum = "h1:pc78L2+BP6ex67gHqr1YjJ3uGo9gKLRCYk2hzzs9P2g=",
        version = "v1.7.11",
    )
    go_repository(
        name = "com_google_cloud_go_cloudtasks",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/cloudtasks",
        sum = "h1:SN2NqXSOdmQzQJjoMV0qLIn6GXG5SzRrRVNrNq2Q6zA=",
        version = "v1.12.13",
    )
    go_repository(
        name = "com_google_cloud_go_compute",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/compute",
        sum = "h1:iii9Z+FhEeZ5cUkGOEqU+GM7MJSyxMgbE7H7j+JndYY=",
        version = "v1.27.5",
    )
    go_repository(
        name = "com_google_cloud_go_compute_metadata",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/compute/metadata",
        sum = "h1:Zr0eK8JbFv6+Wi4ilXAR8FJ3wyNdpxHKJNPos6LTZOY=",
        version = "v0.5.0",
    )
    go_repository(
        name = "com_google_cloud_go_contactcenterinsights",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/contactcenterinsights",
        sum = "h1:KAqbmVHi77C5DwQ5ahpI41czo7LO2AWe0QJLDPfaVmY=",
        version = "v1.13.7",
    )
    go_repository(
        name = "com_google_cloud_go_container",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/container",
        sum = "h1:Pb0GbZIg/KS4A9gbF3J4JHmrgPpBA2y+4v9N04aJkOs=",
        version = "v1.38.1",
    )
    go_repository(
        name = "com_google_cloud_go_containeranalysis",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/containeranalysis",
        sum = "h1:BE8mBsV41BgUFQO3QW9wdpF3s5owx8idOcJ3I2aAoQA=",
        version = "v0.12.2",
    )
    go_repository(
        name = "com_google_cloud_go_datacatalog",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/datacatalog",
        sum = "h1:l8yPkaMTlIX/437kBKGURvk4dtZIbotHBuSX2nLbJY8=",
        version = "v1.21.1",
    )
    go_repository(
        name = "com_google_cloud_go_dataflow",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/dataflow",
        sum = "h1:p80cphmUBav+Htfr9DSQf++P0s8FrQT4BKsGmvYXBxM=",
        version = "v0.9.12",
    )
    go_repository(
        name = "com_google_cloud_go_dataform",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/dataform",
        sum = "h1:4aZ5O9aBHXUgQFZfu4sKjgIJIpzunbxZ1y8GHgtQZG8=",
        version = "v0.9.9",
    )
    go_repository(
        name = "com_google_cloud_go_datafusion",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/datafusion",
        sum = "h1:O5p8qgJg+7sn55JnaEnRr2yMX37bOZTMp3GBOa6dG0o=",
        version = "v1.7.12",
    )
    go_repository(
        name = "com_google_cloud_go_datalabeling",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/datalabeling",
        sum = "h1:iC7Lpzya3QKVLUy8M2J4y+JZrjAFtHg8bvAuLhMpkGw=",
        version = "v0.8.12",
    )
    go_repository(
        name = "com_google_cloud_go_dataplex",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/dataplex",
        sum = "h1:jYcAzyFS1DcnpwBVfnUD8wrRlltgU5L1EQdPshCEO+o=",
        version = "v1.18.3",
    )
    go_repository(
        name = "com_google_cloud_go_dataproc",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/dataproc",
        sum = "h1:W47qHL3W4BPkAIbk4SWmIERwsWBaNnWm0P2sdx3YgGU=",
        version = "v1.12.0",
    )
    go_repository(
        name = "com_google_cloud_go_dataproc_v2",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/dataproc/v2",
        sum = "h1:otFEJPOxzbAniKw4Aa1GVJlxjejR4/qHBlmU+xhY6MI=",
        version = "v2.5.4",
    )
    go_repository(
        name = "com_google_cloud_go_dataqna",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/dataqna",
        sum = "h1:bTiS9ppeA86EnJnXqZZLiQWXglFpyaF2TK/iPkZ/ga0=",
        version = "v0.8.12",
    )
    go_repository(
        name = "com_google_cloud_go_datastore",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/datastore",
        sum = "h1:p5H3bUQltOa26GcMRAxPoNwoqGkq5v8ftx9/ZBB35MI=",
        version = "v1.19.0",
    )
    go_repository(
        name = "com_google_cloud_go_datastream",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/datastream",
        sum = "h1:LpJhP4g8+JGO5dKwhVSblnpB1hk/qA2/+rq68ppkVF8=",
        version = "v1.10.11",
    )
    go_repository(
        name = "com_google_cloud_go_deploy",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/deploy",
        sum = "h1:sperWx8Nk3AFnonH8XXxCdarZfeXZYR7dgmDFoBkuCc=",
        version = "v1.21.2",
    )
    go_repository(
        name = "com_google_cloud_go_dialogflow",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/dialogflow",
        sum = "h1:s4lhL0DZExduaN534Rl3K488sKkes7LHnDQtbpwFHNk=",
        version = "v1.56.0",
    )
    go_repository(
        name = "com_google_cloud_go_dlp",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/dlp",
        sum = "h1:BrKrhNjAi5u8EgIadv1mcjEX4bB7FPPcRvr0Cf9bdN4=",
        version = "v1.17.0",
    )
    go_repository(
        name = "com_google_cloud_go_documentai",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/documentai",
        sum = "h1:bXTTAjRmu7oVlvLqV4lLc7VKqR/IUtgexBPyLDWUs/o=",
        version = "v1.32.0",
    )
    go_repository(
        name = "com_google_cloud_go_domains",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/domains",
        sum = "h1:Ot7K4Vl4Ap/y90VYjyz9qL57e+pAhMYVP0bIM7YnPvI=",
        version = "v0.9.12",
    )
    go_repository(
        name = "com_google_cloud_go_edgecontainer",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/edgecontainer",
        sum = "h1:r/4Yqg3Kji26XbCegwta1c7C92uwO0TUSaTwbzG5s/w=",
        version = "v1.2.6",
    )
    go_repository(
        name = "com_google_cloud_go_errorreporting",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/errorreporting",
        sum = "h1:E/gLk+rL7u5JZB9oq72iL1bnhVlLrnfslrgcptjJEUE=",
        version = "v0.3.1",
    )
    go_repository(
        name = "com_google_cloud_go_essentialcontacts",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/essentialcontacts",
        sum = "h1:zKttHKhAV6LxT/SlahypK+2hBjmIVg9elMn3r0WQ5cY=",
        version = "v1.6.13",
    )
    go_repository(
        name = "com_google_cloud_go_eventarc",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/eventarc",
        sum = "h1:bFkxnUwdOKKgXjCoxpwd9FYV/yBs8iUhIuiJV4R1jlE=",
        version = "v1.13.11",
    )
    go_repository(
        name = "com_google_cloud_go_filestore",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/filestore",
        sum = "h1:ZPE2+k1eyesicuehhHRXEG7WDo3mW/0li8oNnmuyxYE=",
        version = "v1.8.8",
    )
    go_repository(
        name = "com_google_cloud_go_firestore",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/firestore",
        sum = "h1:YwmDHcyrxVRErWcgxunzEaZxtNbc8QoFYA/JOEwDPgc=",
        version = "v1.16.0",
    )
    go_repository(
        name = "com_google_cloud_go_functions",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/functions",
        sum = "h1:50K2iLtj7xj6xqrhdNOL+aVaHwKi4h7qgNWP9ieTDag=",
        version = "v1.18.0",
    )
    go_repository(
        name = "com_google_cloud_go_gaming",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/gaming",
        sum = "h1:5qZmZEWzMf8GEFgm9NeC3bjFRpt7x4S6U7oLbxaf7N8=",
        version = "v1.10.1",
    )
    go_repository(
        name = "com_google_cloud_go_gkebackup",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/gkebackup",
        sum = "h1:ITiOPDl0Q1vgDHdbMvRk0Yk6uEcP8Kq875m6IMJJu6Y=",
        version = "v1.5.5",
    )
    go_repository(
        name = "com_google_cloud_go_gkeconnect",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/gkeconnect",
        sum = "h1:0n3xfOvU+SN2LJRWex81U3xCNfQtPpxjSkrI3XBdudM=",
        version = "v0.8.12",
    )
    go_repository(
        name = "com_google_cloud_go_gkehub",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/gkehub",
        sum = "h1:twVZpPzRnwJQ9UwU3M/Mwn356qboSRo+UxsTmlMtKiM=",
        version = "v0.14.12",
    )
    go_repository(
        name = "com_google_cloud_go_gkemulticloud",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/gkemulticloud",
        sum = "h1:OREoK+FO+5j6eVXdvGsiXHvoFkUZxxoS8WBWk6zWThA=",
        version = "v1.2.5",
    )
    go_repository(
        name = "com_google_cloud_go_grafeas",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/grafeas",
        sum = "h1:D4x32R/cHX3MTofKwirz015uEdVk4uAxvZkZCZkOrF4=",
        version = "v0.3.4",
    )
    go_repository(
        name = "com_google_cloud_go_gsuiteaddons",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/gsuiteaddons",
        sum = "h1:lp9f1VVl7Z4S8uqWTvGvazsMhBFpEbUiqCG2uYJ3LRs=",
        version = "v1.6.12",
    )
    go_repository(
        name = "com_google_cloud_go_iam",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/iam",
        sum = "h1:7zWBXG9ERbMLrzQBRhFliAV+kjcRToDTgQT3CTwYyv4=",
        version = "v1.1.13",
    )
    go_repository(
        name = "com_google_cloud_go_iap",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/iap",
        sum = "h1:rqm2jCKE/uA2iRYxcFY7O88sUBhru5+/OTK4dphIOyM=",
        version = "v1.9.11",
    )
    go_repository(
        name = "com_google_cloud_go_ids",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/ids",
        sum = "h1:9X6gbqXgOztpxR9pl9xkBgG4jMex0oZDrpwaspCLL1k=",
        version = "v1.4.12",
    )
    go_repository(
        name = "com_google_cloud_go_iot",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/iot",
        sum = "h1:udkAi3LvaD7KdwJUegnUyOBVnruL0It1nmV5TktYF7o=",
        version = "v1.7.12",
    )
    go_repository(
        name = "com_google_cloud_go_kms",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/kms",
        sum = "h1:75LSlVs60hyHK3ubs2OHd4sE63OAMcM2BdSJc2bkuM4=",
        version = "v1.18.5",
    )
    go_repository(
        name = "com_google_cloud_go_language",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/language",
        sum = "h1:sgAhzmJ/wZBS/4djQJLpjke52sdDhfKuskoCHSTaCHk=",
        version = "v1.13.1",
    )
    go_repository(
        name = "com_google_cloud_go_lifesciences",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/lifesciences",
        sum = "h1:DGKhxamDcn1v7ieat3sqCjm6HwJqWnrF9Xbq/IDyz80=",
        version = "v0.9.12",
    )
    go_repository(
        name = "com_google_cloud_go_logging",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/logging",
        sum = "h1:v3ktVzXMV7CwHq1MBF65wcqLMA7i+z3YxbUsoK7mOKs=",
        version = "v1.11.0",
    )
    go_repository(
        name = "com_google_cloud_go_longrunning",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/longrunning",
        sum = "h1:5LqSIdERr71CqfUsFlJdBpOkBH8FBCFD7P1nTWy3TYE=",
        version = "v0.5.12",
    )
    go_repository(
        name = "com_google_cloud_go_managedidentities",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/managedidentities",
        sum = "h1:p+n5vvhcpWgwpHoeeUoe+D9/wzIqW5vsWoi2n7YTafA=",
        version = "v1.6.12",
    )
    go_repository(
        name = "com_google_cloud_go_maps",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/maps",
        sum = "h1:ifdbRNVte+Oq0aHVR4lvXMBSvJhtIcK+G9GsWRQDQ9o=",
        version = "v1.11.7",
    )
    go_repository(
        name = "com_google_cloud_go_mediatranslation",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/mediatranslation",
        sum = "h1:26qFQZxj9Rii22kl84HHcJ0zWlaHsVdBJZxAil89ejs=",
        version = "v0.8.12",
    )
    go_repository(
        name = "com_google_cloud_go_memcache",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/memcache",
        sum = "h1:rQxkJUKO9YlENBUHb9WuSb6vBlOrU5xh9Riz81haxW0=",
        version = "v1.10.12",
    )
    go_repository(
        name = "com_google_cloud_go_metastore",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/metastore",
        sum = "h1:yZR2paCUcLscxQLp35FoApsMOFB7pOGcIJTiX6psnlc=",
        version = "v1.13.11",
    )
    go_repository(
        name = "com_google_cloud_go_monitoring",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/monitoring",
        sum = "h1:zwcViK7mT9SV0kzKqLOI3spRadvsmvw/R9z1MHNeC0E=",
        version = "v1.20.4",
    )
    go_repository(
        name = "com_google_cloud_go_networkconnectivity",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/networkconnectivity",
        sum = "h1:zkOTU4GJQQVOD2bKTlUPFIdEG1MQCgNrnwagL43uK8s=",
        version = "v1.14.11",
    )
    go_repository(
        name = "com_google_cloud_go_networkmanagement",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/networkmanagement",
        sum = "h1:dXfIaWKr5vVBBHagmbILBkb7yV+FEsyZmMuTZmG3frk=",
        version = "v1.13.7",
    )
    go_repository(
        name = "com_google_cloud_go_networksecurity",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/networksecurity",
        sum = "h1:BqYfZZHx2koUMiRqEz3BV9AVOsreleSOELi+FZqrEUw=",
        version = "v0.9.12",
    )
    go_repository(
        name = "com_google_cloud_go_notebooks",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/notebooks",
        sum = "h1:7FOp+bFhy1WYKbRpfb190Jhj5Qu4paXv5EErwOD1bFY=",
        version = "v1.11.10",
    )
    go_repository(
        name = "com_google_cloud_go_optimization",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/optimization",
        sum = "h1:jsPO26IqwEs/x3KJQCmHvL9/gQK35JppdxNbuyXPh5Q=",
        version = "v1.6.10",
    )
    go_repository(
        name = "com_google_cloud_go_orchestration",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/orchestration",
        sum = "h1:6KCe2V5E9gCtN09BEzLVTCv8g16LPYzImDqgwXKbnvY=",
        version = "v1.9.7",
    )
    go_repository(
        name = "com_google_cloud_go_orgpolicy",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/orgpolicy",
        sum = "h1:lBKGvA07J42nQpU6X61hQDIv/jcnuJtz/BhnTjGIDYg=",
        version = "v1.12.8",
    )
    go_repository(
        name = "com_google_cloud_go_osconfig",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/osconfig",
        sum = "h1:GoiK/q0OAhaGxZMMapulq+lxZU4BEZn8ado2g3yqfqc=",
        version = "v1.13.3",
    )
    go_repository(
        name = "com_google_cloud_go_oslogin",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/oslogin",
        sum = "h1:ukF32m5YIOUgMQXrJW6RkOLxV/VYPa3f1mDr9OjN8bA=",
        version = "v1.13.8",
    )
    go_repository(
        name = "com_google_cloud_go_phishingprotection",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/phishingprotection",
        sum = "h1:64kH4KgKV4vYJeAqN9dHbxPLFE5yEKcfvV3Rrh0TZTg=",
        version = "v0.8.12",
    )
    go_repository(
        name = "com_google_cloud_go_policytroubleshooter",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/policytroubleshooter",
        sum = "h1:oIc5msMHCZgiYbMJPMuqhj478Eo0oT6HkUnLmYBz/rc=",
        version = "v1.10.10",
    )
    go_repository(
        name = "com_google_cloud_go_privatecatalog",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/privatecatalog",
        sum = "h1:ZmATFJMFK6gbWoDQpLX9y6nmBMeYUCY8Wa5ijc2yKss=",
        version = "v0.9.12",
    )
    go_repository(
        name = "com_google_cloud_go_pubsub",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/pubsub",
        sum = "h1:PVTbzorLryFL5ue8esTS2BfehUs0ahyNOY9qcd+HMOs=",
        version = "v1.42.0",
    )
    go_repository(
        name = "com_google_cloud_go_pubsublite",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/pubsublite",
        sum = "h1:jLQozsEVr+c6tOU13vDugtnaBSUy/PD5zK6mhm+uF1Y=",
        version = "v1.8.2",
    )
    go_repository(
        name = "com_google_cloud_go_recaptchaenterprise",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/recaptchaenterprise",
        sum = "h1:u6EznTGzIdsyOsvm+Xkw0aSuKFXQlyjGE9a4exk6iNQ=",
        version = "v1.3.1",
    )
    go_repository(
        name = "com_google_cloud_go_recaptchaenterprise_v2",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/recaptchaenterprise/v2",
        sum = "h1:qnU+urA6SZlRErosscaJ2DLG4264D6V8S4OgC3RU6QY=",
        version = "v2.14.3",
    )
    go_repository(
        name = "com_google_cloud_go_recommendationengine",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/recommendationengine",
        sum = "h1:X587hwzHqvmKyTR4EzH/QVYtvaCNqeIKhX9QC2iAw4g=",
        version = "v0.8.12",
    )
    go_repository(
        name = "com_google_cloud_go_recommender",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/recommender",
        sum = "h1:3d+XXbeVU9Mt0TW6La+BhVFyCT5M2F1nazhAYrtahfM=",
        version = "v1.12.8",
    )
    go_repository(
        name = "com_google_cloud_go_redis",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/redis",
        sum = "h1:yqidSLL+AE6IPNnEkAK6ZlxXp5c3zrsTTCB1TrpO054=",
        version = "v1.16.5",
    )
    go_repository(
        name = "com_google_cloud_go_resourcemanager",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/resourcemanager",
        sum = "h1:p++iHmmeq9iWTia8WhNmPvBhL7MZsglQpZAYlHCguBs=",
        version = "v1.9.12",
    )
    go_repository(
        name = "com_google_cloud_go_resourcesettings",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/resourcesettings",
        sum = "h1:zRvaQBE1O7wuB/UtX7Lw119r/xGcPzaY1POGpoMEhEs=",
        version = "v1.7.5",
    )
    go_repository(
        name = "com_google_cloud_go_retail",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/retail",
        sum = "h1:seOuQ16gMSxxre//JZy7lEdAKWwHQJMLYBmSfifJ/VI=",
        version = "v1.17.5",
    )
    go_repository(
        name = "com_google_cloud_go_run",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/run",
        sum = "h1:grsUhL/Dlp7z5z2A4Nxi1oxEyktBkyB8VuobO6fuILs=",
        version = "v1.4.1",
    )
    go_repository(
        name = "com_google_cloud_go_scheduler",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/scheduler",
        sum = "h1:KEM2/3r4NIn6eOIL1tAEN1Qrot8xqKYuW1QKEQ+GyFU=",
        version = "v1.10.13",
    )
    go_repository(
        name = "com_google_cloud_go_secretmanager",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/secretmanager",
        sum = "h1:0ZEl/LuoB4xQsjVfQt3Gi/dZfOv36n4JmdPrMargzYs=",
        version = "v1.13.6",
    )
    go_repository(
        name = "com_google_cloud_go_security",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/security",
        sum = "h1:FzjVVdJKgfHmDt1gsecHehVewA0wLuruHvA1g4o5k4c=",
        version = "v1.17.5",
    )
    go_repository(
        name = "com_google_cloud_go_securitycenter",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/securitycenter",
        sum = "h1:rf1n9DviaHlkjqG/Acy61nsQxSGL4w8hIQoSraNNQBM=",
        version = "v1.34.0",
    )
    go_repository(
        name = "com_google_cloud_go_servicecontrol",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/servicecontrol",
        sum = "h1:d0uV7Qegtfaa7Z2ClDzr9HJmnbJW7jn0WhZ7wOX6hLE=",
        version = "v1.11.1",
    )
    go_repository(
        name = "com_google_cloud_go_servicedirectory",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/servicedirectory",
        sum = "h1:KPlLc16HUiUp5/dGHF7KlBUEub13Ps76J91xCMBG+5U=",
        version = "v1.11.12",
    )
    go_repository(
        name = "com_google_cloud_go_servicemanagement",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/servicemanagement",
        sum = "h1:fopAQI/IAzlxnVeiKn/8WiV6zKndjFkvi+gzu+NjywY=",
        version = "v1.8.0",
    )
    go_repository(
        name = "com_google_cloud_go_serviceusage",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/serviceusage",
        sum = "h1:rXyq+0+RSIm3HFypctp7WoXxIA563rn206CfMWdqXX4=",
        version = "v1.6.0",
    )
    go_repository(
        name = "com_google_cloud_go_shell",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/shell",
        sum = "h1:UCDVhq9IkB1RWhUIJxj9Xr/c+BVVxMSAnnJUGjPfk4U=",
        version = "v1.7.12",
    )
    go_repository(
        name = "com_google_cloud_go_spanner",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/spanner",
        sum = "h1:h8xfobxh5lQu4qJVMPH+wSiyU+ZM6ZTxRNqGeu9iIVA=",
        version = "v1.67.0",
    )
    go_repository(
        name = "com_google_cloud_go_speech",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/speech",
        sum = "h1:sgJ+sBzamry/ZBhbIZX6Dmv/BnrTAvWLXeJT1bmugnU=",
        version = "v1.24.1",
    )
    go_repository(
        name = "com_google_cloud_go_storage",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/storage",
        sum = "h1:CcxnSohZwizt4LCzQHWvBf1/kvtHUn7gk9QERXPyXFs=",
        version = "v1.43.0",
    )
    go_repository(
        name = "com_google_cloud_go_storagetransfer",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/storagetransfer",
        sum = "h1:AF5iHhnbiVC4BEKf1b8ujWeUuXCfpRzO9aclF2j2A1w=",
        version = "v1.10.11",
    )
    go_repository(
        name = "com_google_cloud_go_talent",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/talent",
        sum = "h1:DLrLO6LVl6T7v07Jc3+4IaI+sDFRbgd7MTEbTow5qVE=",
        version = "v1.6.13",
    )
    go_repository(
        name = "com_google_cloud_go_texttospeech",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/texttospeech",
        sum = "h1:W33C7hjh61V1HVAh4E1RqAx2hSPIebmilYqMuqvP/HQ=",
        version = "v1.7.12",
    )
    go_repository(
        name = "com_google_cloud_go_tpu",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/tpu",
        sum = "h1:n54G/s4O6t2sbTiTkhj795JW6iCBSzI1ccrXp+GAP6c=",
        version = "v1.6.12",
    )
    go_repository(
        name = "com_google_cloud_go_trace",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/trace",
        sum = "h1:GoGZv1iAXEa73HgSGNjRl2vKqp5/f2AeKqErRFXA2kg=",
        version = "v1.10.12",
    )
    go_repository(
        name = "com_google_cloud_go_translate",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/translate",
        sum = "h1:ncOb+dtBr65+5Ay9VotOA8j5RlrUJXB+qdq+xqpV4Ls=",
        version = "v1.11.0",
    )
    go_repository(
        name = "com_google_cloud_go_video",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/video",
        sum = "h1:G2gFE34k6TIC0CHW1OTbF6tKfzA3X+MbjkoLblu0vWU=",
        version = "v1.22.1",
    )
    go_repository(
        name = "com_google_cloud_go_videointelligence",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/videointelligence",
        sum = "h1:dFCXde/zOkP1yhM8aCuFVC+smix46sP2U56OywCOkAQ=",
        version = "v1.11.12",
    )
    go_repository(
        name = "com_google_cloud_go_vision",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/vision",
        sum = "h1:/CsSTkbmO9HC8iQpxbK8ATms3OQaX3YQUeTMGCxlaK4=",
        version = "v1.2.0",
    )
    go_repository(
        name = "com_google_cloud_go_vision_v2",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/vision/v2",
        sum = "h1:4hWiRo2j4zzmCzXG+SkJVYq0dvR6TklFHkxdsmdfMsU=",
        version = "v2.8.7",
    )
    go_repository(
        name = "com_google_cloud_go_vmmigration",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/vmmigration",
        sum = "h1:+X5l9sfrevUi5EeOM7LhzFFzGVT/N7u0TJY7jdIiIQA=",
        version = "v1.7.12",
    )
    go_repository(
        name = "com_google_cloud_go_vmwareengine",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/vmwareengine",
        sum = "h1:UChEIPaM3wxBXKLy7Ooqeey3YNesta7PR5D2h7lI61I=",
        version = "v1.2.1",
    )
    go_repository(
        name = "com_google_cloud_go_vpcaccess",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/vpcaccess",
        sum = "h1:n077TcPH7S8RjZGBwHWykVfoVaa41O5VK9xn8KR18+0=",
        version = "v1.7.12",
    )
    go_repository(
        name = "com_google_cloud_go_webrisk",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/webrisk",
        sum = "h1:2WWCTU5744V0AsZomJxzH18LG7jlL13z1iDzgMWAJOQ=",
        version = "v1.9.12",
    )
    go_repository(
        name = "com_google_cloud_go_websecurityscanner",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/websecurityscanner",
        sum = "h1:0RJvr/1Eybjt6klGMrW4U5DVitv1P+BoLmrRU6Xmzc0=",
        version = "v1.6.12",
    )
    go_repository(
        name = "com_google_cloud_go_workflows",
        build_file_proto_mode = "disable",
        importpath = "cloud.google.com/go/workflows",
        sum = "h1:9pfL+XeaaNDEPTc02VvX70qW36cBrTHmcH1plZwOI7s=",
        version = "v1.12.11",
    )
    go_repository(
        name = "com_lukechampine_uint128",
        build_file_proto_mode = "disable",
        importpath = "lukechampine.com/uint128",
        sum = "h1:cDdUVfRwDUDovz610ABgFD17nXD4/uDgVHl2sC3+sbo=",
        version = "v1.3.0",
    )
    go_repository(
        name = "com_shuralyov_dmitri_gpu_mtl",
        build_file_proto_mode = "disable",
        importpath = "dmitri.shuralyov.com/gpu/mtl",
        sum = "h1:VpgP7xuJadIUuKccphEpTJnWhS2jkQyMt6Y7pJCD7fY=",
        version = "v0.0.0-20190408044501-666a987793e9",
    )

    go_repository(
        name = "grpc_ecosystem_grpc_gateway",  # keep
        build_file_generation = "on",  # keep
        importpath = "github.com/grpc-ecosystem/grpc-gateway/v2",  # keep
        sum = "h1:/sDbPb60SusIXjiJGYLUoS/rAQurQmvGWmwn2bBPM9c=",  # keep
        version = "v2.11.1",  # keep
    )
    go_repository(
        name = "ht_sr_git_sbinet_gg",
        build_file_proto_mode = "disable",
        importpath = "git.sr.ht/~sbinet/gg",
        sum = "h1:6V43j30HM623V329xA9Ntq+WJrMjDxRjuAB1LFWF5m8=",
        version = "v0.5.0",
    )
    go_repository(
        name = "in_gopkg_alecthomas_kingpin_v2",
        build_file_proto_mode = "disable",
        importpath = "gopkg.in/alecthomas/kingpin.v2",
        replace = "github.com/alecthomas/kingpin",
        sum = "h1:aDITxVUQ/3KBhpVWX57Vo9ntGTxoRw1F0T6/x/tRzNU=",
        version = "v1.3.8-0.20210301060133-17f40c25f497",
    )
    go_repository(
        name = "in_gopkg_check_v1",
        build_file_proto_mode = "disable",
        importpath = "gopkg.in/check.v1",
        sum = "h1:Hei/4ADfdWqJk1ZMxUNpqntNwaWcugrBjAiHlqqRiVk=",
        version = "v1.0.0-20201130134442-10cb98267c6c",
    )
    go_repository(
        name = "in_gopkg_errgo_v2",
        build_file_proto_mode = "disable",
        importpath = "gopkg.in/errgo.v2",
        sum = "h1:0vLT13EuvQ0hNvakwLuFZ/jYrLp5F3kcWHXdRggjCE8=",
        version = "v2.1.0",
    )
    go_repository(
        name = "in_gopkg_evanphx_json_patch_v4",
        build_file_proto_mode = "disable",
        importpath = "gopkg.in/evanphx/json-patch.v4",
        sum = "h1:n6jtcsulIzXPJaxegRbvFNNrZDjbij7ny3gmSPG+6V4=",
        version = "v4.12.0",
    )
    go_repository(
        name = "in_gopkg_fsnotify_v1",
        build_file_proto_mode = "disable",
        importpath = "gopkg.in/fsnotify.v1",
        sum = "h1:xOHLXZwVvI9hhs+cLKq5+I5onOuwQLhQwiu63xxlHs4=",
        version = "v1.4.7",
    )
    go_repository(
        name = "in_gopkg_inf_v0",
        build_file_proto_mode = "disable",
        importpath = "gopkg.in/inf.v0",
        sum = "h1:73M5CoZyi3ZLMOyDlQh031Cx6N9NDJ2Vvfl76EDAgDc=",
        version = "v0.9.1",
    )
    go_repository(
        name = "in_gopkg_ini_v1",
        build_file_proto_mode = "disable",
        importpath = "gopkg.in/ini.v1",
        sum = "h1:Dgnx+6+nfE+IfzjUEISNeydPJh9AXNNsWbGP9KzCsOA=",
        version = "v1.67.0",
    )
    go_repository(
        name = "in_gopkg_telebot_v3",
        build_file_proto_mode = "disable",
        importpath = "gopkg.in/telebot.v3",
        sum = "h1:3I4LohaAyJBiivGmkfB+CiVu7QFOWkuZ4+KHgO/G3rs=",
        version = "v3.2.1",
    )
    go_repository(
        name = "in_gopkg_tomb_v1",
        build_file_proto_mode = "disable",
        importpath = "gopkg.in/tomb.v1",
        sum = "h1:uRGJdciOHaEIrze2W8Q3AKkepLTh2hOroT7a+7czfdQ=",
        version = "v1.0.0-20141024135613-dd632973f1e7",
    )
    go_repository(
        name = "in_gopkg_yaml_v2",
        build_file_proto_mode = "disable",
        importpath = "gopkg.in/yaml.v2",
        sum = "h1:D8xgwECY7CYvx+Y2n4sBz93Jn9JRvxdiyyo8CTfuKaY=",
        version = "v2.4.0",
    )
    go_repository(
        name = "in_gopkg_yaml_v3",
        build_file_proto_mode = "disable",
        importpath = "gopkg.in/yaml.v3",
        sum = "h1:fxVm/GzAzEWqLHuvctI91KS9hhNmmWOoWu0XTYJS7CA=",
        version = "v3.0.1",
    )
    go_repository(
        name = "io_k8s_api",
        build_file_proto_mode = "disable",
        importpath = "k8s.io/api",
        sum = "h1:b9LiSjR2ym/SzTOlfMHm1tr7/21aD7fSkqgD/CVJBCo=",
        version = "v0.31.0",
    )
    go_repository(
        name = "io_k8s_apimachinery",
        build_file_proto_mode = "disable",
        importpath = "k8s.io/apimachinery",
        sum = "h1:mhcUBbj7KUjaVhyXILglcVjuS4nYXiwC+KKFBgIVy7U=",
        version = "v0.31.1",
    )
    go_repository(
        name = "io_k8s_client_go",
        build_file_proto_mode = "disable",
        importpath = "k8s.io/client-go",
        sum = "h1:QqEJzNjbN2Yv1H79SsS+SWnXkBgVu4Pj3CJQgbx0gI8=",
        version = "v0.31.0",
    )
    go_repository(
        name = "io_k8s_klog",
        build_file_proto_mode = "disable",
        importpath = "k8s.io/klog",
        sum = "h1:Pt+yjF5aB1xDSVbau4VsWe+dQNzA0qv1LlXdC2dF6Q8=",
        version = "v1.0.0",
    )
    go_repository(
        name = "io_k8s_klog_v2",
        build_file_proto_mode = "disable",
        importpath = "k8s.io/klog/v2",
        sum = "h1:n9Xl7H1Xvksem4KFG4PYbdQCQxqc/tTUyrgXaOhHSzk=",
        version = "v2.130.1",
    )
    go_repository(
        name = "io_k8s_kube_openapi",
        build_file_proto_mode = "disable",
        importpath = "k8s.io/kube-openapi",
        sum = "h1:BZqlfIlq5YbRMFko6/PM7FjZpUb45WallggurYhKGag=",
        version = "v0.0.0-20240228011516-70dd3763d340",
    )
    go_repository(
        name = "io_k8s_sigs_json",
        build_file_proto_mode = "disable",
        importpath = "sigs.k8s.io/json",
        sum = "h1:EDPBXCAspyGV4jQlpZSudPeMmr1bNJefnuqLsRAsHZo=",
        version = "v0.0.0-20221116044647-bc3834ca7abd",
    )
    go_repository(
        name = "io_k8s_sigs_structured_merge_diff_v4",
        build_file_proto_mode = "disable",
        importpath = "sigs.k8s.io/structured-merge-diff/v4",
        sum = "h1:150L+0vs/8DA78h1u02ooW1/fFq/Lwr+sGiqlzvrtq4=",
        version = "v4.4.1",
    )
    go_repository(
        name = "io_k8s_sigs_yaml",
        build_file_proto_mode = "disable",
        importpath = "sigs.k8s.io/yaml",
        sum = "h1:Mk1wCc2gy/F0THH0TAp1QYyJNzRm2KCLy3o5ASXVI5E=",
        version = "v1.4.0",
    )
    go_repository(
        name = "io_k8s_utils",
        build_file_proto_mode = "disable",
        importpath = "k8s.io/utils",
        sum = "h1:pUdcCO1Lk/tbT5ztQWOBi5HBgbBP1J8+AsQnQCKsi8A=",
        version = "v0.0.0-20240711033017-18e509b52bc8",
    )
    go_repository(
        name = "io_opencensus_go",
        build_file_proto_mode = "disable",
        importpath = "go.opencensus.io",
        sum = "h1:y73uSU6J157QMP2kn2r30vwW1A2W2WFwSCGnAVxeaD0=",
        version = "v0.24.0",
    )
    go_repository(
        name = "io_opentelemetry_go_collector_pdata",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/collector/pdata",
        sum = "h1:wXZjtQA7Vy5HFqco+yA95ENyMQU5heBB1IxMHQf6mUk=",
        version = "v1.14.1",
    )
    go_repository(
        name = "io_opentelemetry_go_collector_semconv",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/collector/semconv",
        sum = "h1:Txk9tauUnamZaxS5vlf1O0uZ4VD6nioRBR0nX8L/fU4=",
        version = "v0.108.1",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_instrumentation_google_golang_org_grpc_otelgrpc",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc",
        sum = "h1:4Pp6oUg3+e/6M4C0A/3kJ2VYa++dsWVTtGgLVj5xtHg=",
        version = "v0.49.0",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_instrumentation_net_http_otelhttp",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp",
        sum = "h1:4K4tsIXefpVJtvA/8srF4V4y0akAoPHkIslgAkjixJA=",
        version = "v0.53.0",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_propagators_autoprop",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/contrib/propagators/autoprop",
        sum = "h1:h/O1OcNbqrFilsMKfG6MJWWpx8gzCDfn9D+1W7lU3lE=",
        version = "v0.54.0",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_propagators_aws",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/contrib/propagators/aws",
        sum = "h1:mqadbdNBhn/MVOcNx0dEZAaOaomKKdnsM0QNBmFegiI=",
        version = "v1.29.0",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_propagators_b3",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/contrib/propagators/b3",
        sum = "h1:hNjyoRsAACnhoOLWupItUjABzeYmX3GTTZLzwJluJlk=",
        version = "v1.29.0",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_propagators_jaeger",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/contrib/propagators/jaeger",
        sum = "h1:+YPiqF5rR6PqHBlmEFLPumbSP0gY0WmCGFayXRcCLvs=",
        version = "v1.29.0",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_propagators_ot",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/contrib/propagators/ot",
        sum = "h1:CaJU78FvXrA6ajjp1dOdcABBEjh529+hl396RTqc2LQ=",
        version = "v1.29.0",
    )
    go_repository(
        name = "io_opentelemetry_go_contrib_samplers_jaegerremote",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/contrib/samplers/jaegerremote",
        sum = "h1:qKi9ntCcronqWqfuKxqrxZlZd82jXJEgGiAWH1+phxo=",
        version = "v0.23.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/otel",
        sum = "h1:NsJcKPIW0D0H3NgzPDHmo0WW6SptzPdqg/L1zsIm2hY=",
        version = "v1.31.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_bridge_opentracing",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/otel/bridge/opentracing",
        sum = "h1:S6SA1IQdNHgfZfgkaWBKQqNIlMNiPoyQDACii2uKQ9k=",
        version = "v1.31.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_exporters_jaeger",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/otel/exporters/jaeger",
        sum = "h1:YhxxmXZ011C0aDZKoNw+juVWAmEfv/0W2XBOv9aHTaA=",
        version = "v1.16.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_exporters_otlp_otlptrace",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/otel/exporters/otlp/otlptrace",
        sum = "h1:dIIDULZJpgdiHz5tXrTgKIMLkus6jEFa7x5SOKcyR7E=",
        version = "v1.29.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_exporters_otlp_otlptrace_otlptracegrpc",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc",
        sum = "h1:nSiV3s7wiCam610XcLbYOmMfJxB9gO4uK3Xgv5gmTgg=",
        version = "v1.29.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_exporters_otlp_otlptrace_otlptracehttp",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp",
        sum = "h1:JAv0Jwtl01UFiyWZEMiJZBiTlv5A50zNs8lsthXqIio=",
        version = "v1.29.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_metric",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/otel/metric",
        sum = "h1:FSErL0ATQAmYHUIzSezZibnyVlft1ybhy4ozRPcF2fE=",
        version = "v1.31.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_sdk",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/otel/sdk",
        sum = "h1:vkqKjk7gwhS8VaWb0POZKmIEDimRCMsopNYnriHyryo=",
        version = "v1.29.0",
    )
    go_repository(
        name = "io_opentelemetry_go_otel_trace",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/otel/trace",
        sum = "h1:ffjsj1aRouKewfr85U2aGagJ46+MvodynlQ1HYdmJys=",
        version = "v1.31.0",
    )
    go_repository(
        name = "io_opentelemetry_go_proto_otlp",
        build_file_proto_mode = "disable",
        importpath = "go.opentelemetry.io/proto/otlp",
        sum = "h1:TrMUixzpM0yuc/znrFTP9MMRh8trP93mkCiDVeXrui0=",
        version = "v1.3.1",
    )
    go_repository(
        name = "io_rsc_binaryregexp",
        build_file_proto_mode = "disable",
        importpath = "rsc.io/binaryregexp",
        sum = "h1:HfqmD5MEmC0zvwBuF187nq9mdnXjXsSivRiXN7SmRkE=",
        version = "v0.2.0",
    )
    go_repository(
        name = "io_rsc_pdf",
        build_file_proto_mode = "disable",
        importpath = "rsc.io/pdf",
        sum = "h1:k1MczvYDUvJBe93bYd7wrZLLUEcLZAuF824/I4e5Xr4=",
        version = "v0.1.1",
    )
    go_repository(
        name = "io_rsc_quote_v3",
        build_file_proto_mode = "disable",
        importpath = "rsc.io/quote/v3",
        sum = "h1:9JKUTTIUgS6kzR9mK1YuGKv6Nl+DijDNIc0ghT58FaY=",
        version = "v3.1.0",
    )
    go_repository(
        name = "io_rsc_sampler",
        build_file_proto_mode = "disable",
        importpath = "rsc.io/sampler",
        sum = "h1:7uVkIFmeBqHfdjD+gZwtXXI+RODJ2Wc4O7MPEh/QiW4=",
        version = "v1.3.0",
    )
    go_repository(
        name = "net_howett_plist",
        build_file_proto_mode = "disable",
        importpath = "howett.net/plist",
        sum = "h1:jhnBjNi9UFpfpl8YZhA9CrOqpnJdvzuiHsl/dnxl11M=",
        version = "v0.0.0-20181124034731-591f970eefbb",
    )
    go_repository(
        name = "net_zenhack_go_util",
        build_file_proto_mode = "disable",
        importpath = "zenhack.net/go/util",
        sum = "h1:yksDCGMVzyn3vlyf0GZ3huiF5FFaMGQpQ3UJvR0EoGA=",
        version = "v0.0.0-20230414204917-531d38494cf5",
    )
    go_repository(
        name = "org_capnproto_go_capnp_v3",
        build_file_proto_mode = "disable",
        importpath = "capnproto.org/go/capnp/v3",
        sum = "h1:iABQan/YiHFCgSXym5aNj27osapnEgAk4WaWYqb4sQM=",
        version = "v3.0.0-alpha.30",
    )
    go_repository(
        name = "org_gioui",
        build_file_proto_mode = "disable",
        importpath = "gioui.org",
        sum = "h1:K72hopUosKG3ntOPNG4OzzbuhxGuVf06fa2la1/H/Ho=",
        version = "v0.0.0-20210308172011-57750fc8a0a6",
    )
    go_repository(
        name = "org_go4_intern",
        build_file_proto_mode = "disable",
        importpath = "go4.org/intern",
        sum = "h1:ae7kzL5Cfdmcecbh22ll7lYP3iuUdnfnhiPcSaDgH/8=",
        version = "v0.0.0-20230525184215-6c62f75575cb",
    )
    go_repository(
        name = "org_go4_unsafe_assume_no_moving_gc",
        build_file_proto_mode = "disable",
        importpath = "go4.org/unsafe/assume-no-moving-gc",
        sum = "h1:WJhcL4p+YeDxmZWg141nRm7XC8IDmhz7lk5GpadO1Sg=",
        version = "v0.0.0-20230525183740-e7c30c78aeb2",
    )
    go_repository(
        name = "org_golang_google_api",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/api",
        sum = "h1:Ude4N8FvTKnnQJHU48RFI40jOBgIrL8Zqr3/QeST6yU=",
        version = "v0.195.0",
    )
    go_repository(
        name = "org_golang_google_appengine",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/appengine",
        sum = "h1:IhEN5q69dyKagZPYMSdIjS2HqprW324FRQZJcGqPAsM=",
        version = "v1.6.8",
    )
    go_repository(
        name = "org_golang_google_genproto",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/genproto",
        sum = "h1:TYOEhrQMrNDTAd2rX9m+WgGr8Ku6YNuj1D7OX6rWSok=",
        version = "v0.0.0-20240823204242-4ba0660f739c",
    )
    go_repository(
        name = "org_golang_google_genproto_googleapis_api",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/genproto/googleapis/api",
        sum = "h1:3RgNmBoI9MZhsj3QxC+AP/qQhNwpCLOvYDYYsFrhFt0=",
        version = "v0.0.0-20240827150818-7e3bb234dfed",
    )
    go_repository(
        name = "org_golang_google_genproto_googleapis_bytestream",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/genproto/googleapis/bytestream",
        sum = "h1:5SFTbgH011A1/MostoGp5314PMnSH9ZLxZX/xynmp64=",
        version = "v0.0.0-20240823204242-4ba0660f739c",
    )
    go_repository(
        name = "org_golang_google_genproto_googleapis_rpc",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/genproto/googleapis/rpc",
        sum = "h1:pPJltXNxVzT4pK9yD8vR9X75DaWYYmLGMsEvBfFQZzQ=",
        version = "v0.0.0-20240903143218-8af14fe29dc1",
    )
    go_repository(
        name = "org_golang_google_grpc",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/grpc",
        replace = "google.golang.org/grpc",
        sum = "h1:MUeiw1B2maTVZthpU5xvASfTh3LDbxHd6IJ6QQVU+xM=",
        version = "v1.63.2",
    )
    go_repository(
        name = "org_golang_google_grpc_cmd_protoc_gen_go_grpc",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/grpc/cmd/protoc-gen-go-grpc",
        sum = "h1:M1YKkFIboKNieVO5DLUEVzQfGwJD30Nv2jfUgzb5UcE=",
        version = "v1.1.0",
    )
    go_repository(
        name = "org_golang_google_grpc_examples",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/grpc/examples",
        sum = "h1:vh/88xB6bVCYsvXtGnKcQGJLMt2fPUFwdSJrVfS2km8=",
        version = "v0.0.0-20211119005141-f45e61797429",
    )
    go_repository(
        name = "org_golang_google_protobuf",
        build_file_proto_mode = "disable",
        importpath = "google.golang.org/protobuf",
        sum = "h1:m3LfL6/Ca+fqnjnlqQXNpFPABW1UD7mjh8KO2mKFytA=",
        version = "v1.35.1",
    )
    go_repository(
        name = "org_golang_x_crypto",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/crypto",
        sum = "h1:GBDwsMXVQi34v5CCYUm2jkJvu4cbtru2U4TN2PSyQnw=",
        version = "v0.28.0",
    )
    go_repository(
        name = "org_golang_x_exp",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/exp",
        sum = "h1:yixxcjnhBmY0nkL253HFVIm0JsFHwrHdT3Yh6szTnfY=",
        version = "v0.0.0-20240613232115-7f521ea00fb8",
    )
    go_repository(
        name = "org_golang_x_image",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/image",
        sum = "h1:tNgSxAFe3jC4uYqvZdTr84SZoM1KfwdC9SKIFrLjFn4=",
        version = "v0.14.0",
    )
    go_repository(
        name = "org_golang_x_lint",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/lint",
        sum = "h1:VLliZ0d+/avPrXXH+OakdXhpJuEoBZuwh1m2j7U6Iug=",
        version = "v0.0.0-20210508222113-6edffad5e616",
    )
    go_repository(
        name = "org_golang_x_mobile",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/mobile",
        sum = "h1:4+4C/Iv2U4fMZBiMCc98MG1In4gJY5YRhtpDNeDeHWs=",
        version = "v0.0.0-20190719004257-d2bd2a29d028",
    )
    go_repository(
        name = "org_golang_x_mod",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/mod",
        sum = "h1:vvrHzRwRfVKSiLrG+d4FMl/Qi4ukBCE6kZlTUkDYRT0=",
        version = "v0.21.0",
    )
    go_repository(
        name = "org_golang_x_net",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/net",
        sum = "h1:AcW1SDZMkb8IpzCdQUaIq2sP4sZ4zw+55h6ynffypl4=",
        version = "v0.30.0",
    )
    go_repository(
        name = "org_golang_x_oauth2",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/oauth2",
        sum = "h1:PbgcYx2W7i4LvjJWEbf0ngHV6qJYr86PkAV3bXdLEbs=",
        version = "v0.23.0",
    )
    go_repository(
        name = "org_golang_x_sync",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/sync",
        sum = "h1:3NFvSEYkUoMifnESzZl15y791HH1qU2xm6eCJU5ZPXQ=",
        version = "v0.8.0",
    )
    go_repository(
        name = "org_golang_x_sys",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/sys",
        sum = "h1:KHjCJyddX0LoSTb3J+vWpupP9p0oznkqVk/IfjymZbo=",
        version = "v0.26.0",
    )
    go_repository(
        name = "org_golang_x_telemetry",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/telemetry",
        sum = "h1:zf5N6UOrA487eEFacMePxjXAJctxKmyjKUsjA11Uzuk=",
        version = "v0.0.0-20240521205824-bda55230c457",
    )
    go_repository(
        name = "org_golang_x_term",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/term",
        sum = "h1:WtHI/ltw4NvSUig5KARz9h521QvRC8RmF/cuYqifU24=",
        version = "v0.25.0",
    )
    go_repository(
        name = "org_golang_x_text",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/text",
        sum = "h1:kTxAhCbGbxhK0IwgSKiMO5awPoDQ0RpfiVYBfK860YM=",
        version = "v0.19.0",
    )
    go_repository(
        name = "org_golang_x_time",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/time",
        sum = "h1:ntUhktv3OPE6TgYxXWv9vKvUSJyIFJlyohwbkEwPrKQ=",
        version = "v0.7.0",
    )
    go_repository(
        name = "org_golang_x_tools",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/tools",
        sum = "h1:J1shsA93PJUEVaUSaay7UXAyE8aimq3GW0pjlolpa24=",
        version = "v0.24.0",
    )
    go_repository(
        name = "org_golang_x_xerrors",
        build_file_proto_mode = "disable",
        importpath = "golang.org/x/xerrors",
        sum = "h1:+cNy6SZtPcJQH3LJVLOSmiC7MMxXNOb3PU/VUEz+EhU=",
        version = "v0.0.0-20231012003039-104605ab7028",
    )
    go_repository(
        name = "org_gonum_v1_gonum",
        build_file_proto_mode = "disable",
        importpath = "gonum.org/v1/gonum",
        sum = "h1:2lYxjRbTYyxkJxlhC+LvJIx3SsANPdRybu1tGj9/OrQ=",
        version = "v0.15.0",
    )
    go_repository(
        name = "org_gonum_v1_netlib",
        build_file_proto_mode = "disable",
        importpath = "gonum.org/v1/netlib",
        sum = "h1:OE9mWmgKkjJyEmDAAtGMPjXu+YNeGvK9VTSHY6+Qihc=",
        version = "v0.0.0-20190313105609-8cb42192e0e0",
    )
    go_repository(
        name = "org_gonum_v1_plot",
        build_file_proto_mode = "disable",
        importpath = "gonum.org/v1/plot",
        sum = "h1:+LBDVFYwFe4LHhdP8coW6296MBEY4nQ+Y4vuUpJopcE=",
        version = "v0.14.0",
    )
    go_repository(
        name = "org_modernc_cc_v3",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/cc/v3",
        sum = "h1:P3g79IUS/93SYhtoeaHW+kRCIrYaxJ27MFPv+7kaTOw=",
        version = "v3.40.0",
    )
    go_repository(
        name = "org_modernc_ccgo_v3",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/ccgo/v3",
        sum = "h1:Mkgdzl46i5F/CNR/Kj80Ri59hC8TKAhZrYSaqvkwzUw=",
        version = "v3.16.13",
    )
    go_repository(
        name = "org_modernc_ccorpus",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/ccorpus",
        sum = "h1:J16RXiiqiCgua6+ZvQot4yUuUy8zxgqbqEEUuGPlISk=",
        version = "v1.11.6",
    )
    go_repository(
        name = "org_modernc_httpfs",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/httpfs",
        sum = "h1:AAgIpFZRXuYnkjftxTAZwMIiwEqAfk8aVB2/oA6nAeM=",
        version = "v1.0.6",
    )
    go_repository(
        name = "org_modernc_libc",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/libc",
        sum = "h1:wymSbZb0AlrjdAVX3cjreCHTPCpPARbQXNz6BHPzdwQ=",
        version = "v1.22.4",
    )
    go_repository(
        name = "org_modernc_mathutil",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/mathutil",
        sum = "h1:rV0Ko/6SfM+8G+yKiyI830l3Wuz1zRutdslNoQ0kfiQ=",
        version = "v1.5.0",
    )
    go_repository(
        name = "org_modernc_memory",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/memory",
        sum = "h1:N+/8c5rE6EqugZwHii4IFsaJ7MUhoWX07J5tC/iI5Ds=",
        version = "v1.5.0",
    )
    go_repository(
        name = "org_modernc_opt",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/opt",
        sum = "h1:3XOZf2yznlhC+ibLltsDGzABUGVx8J6pnFMS3E4dcq4=",
        version = "v0.1.3",
    )
    go_repository(
        name = "org_modernc_sqlite",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/sqlite",
        sum = "h1:ixuUG0QS413Vfzyx6FWx6PYTmHaOegTY+hjzhn7L+a0=",
        version = "v1.21.2",
    )
    go_repository(
        name = "org_modernc_strutil",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/strutil",
        sum = "h1:fNMm+oJklMGYfU9Ylcywl0CO5O6nTfaowNsh2wpPjzY=",
        version = "v1.1.3",
    )
    go_repository(
        name = "org_modernc_tcl",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/tcl",
        sum = "h1:mOQwiEK4p7HruMZcwKTZPw/aqtGM4aY00uzWhlKKYws=",
        version = "v1.15.1",
    )
    go_repository(
        name = "org_modernc_token",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/token",
        sum = "h1:Xl7Ap9dKaEs5kLoOQeQmPWevfnk/DM5qcLcYlA8ys6Y=",
        version = "v1.1.0",
    )
    go_repository(
        name = "org_modernc_z",
        build_file_proto_mode = "disable",
        importpath = "modernc.org/z",
        sum = "h1:xkDw/KepgEjeizO2sNco+hqYkU12taxQFqPEmgm1GWE=",
        version = "v1.7.0",
    )
    go_repository(
        name = "org_mongodb_go_mongo_driver",
        build_file_proto_mode = "disable",
        importpath = "go.mongodb.org/mongo-driver",
        sum = "h1:P98w8egYRjYe3XDjxhYJagTokP/H6HzlsnojRgZRd80=",
        version = "v1.14.0",
    )
    go_repository(
        name = "org_uber_go_atomic",
        build_file_proto_mode = "disable",
        importpath = "go.uber.org/atomic",
        sum = "h1:ZvwS0R+56ePWxUNi+Atn9dWONBPp/AUETXlHW0DxSjE=",
        version = "v1.11.0",
    )
    go_repository(
        name = "org_uber_go_automaxprocs",
        build_file_proto_mode = "disable",
        importpath = "go.uber.org/automaxprocs",
        sum = "h1:kWazyxZUrS3Gs4qUpbwo5kEIMGe/DAvi5Z4tl2NW4j8=",
        version = "v1.5.3",
    )
    go_repository(
        name = "org_uber_go_goleak",
        build_file_proto_mode = "disable",
        importpath = "go.uber.org/goleak",
        sum = "h1:2K3zAYmnTNqV73imy9J1T3WC+gmCePx2hEGkimedGto=",
        version = "v1.3.0",
    )
    go_repository(
        name = "org_uber_go_multierr",
        build_file_proto_mode = "disable",
        importpath = "go.uber.org/multierr",
        sum = "h1:blXXJkSxSSfBVBlC76pxqeO+LN3aDfLQo+309xJstO0=",
        version = "v1.11.0",
    )
    go_repository(
        name = "tech_einride_go_aip",
        build_file_proto_mode = "disable",
        importpath = "go.einride.tech/aip",
        sum = "h1:XfV+NQX6L7EOYK11yoHHFtndeaWh3KbD9/cN/6iWEt8=",
        version = "v0.66.0",
    )
    go_repository(
        name = "tools_gotest_v3",
        build_file_proto_mode = "disable",
        importpath = "gotest.tools/v3",
        sum = "h1:EENdUnS3pdur5nybKYIh2Vfgc8IUNBjxDPSjtiJcOzU=",
        version = "v3.5.1",
    )
