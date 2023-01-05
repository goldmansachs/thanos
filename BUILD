load("@io_bazel_rules_go//go:def.bzl", "go_library")
load("@bazel_gazelle//:def.bzl", "gazelle")

# gazelle:prefix github.com/prometheus/common
# gazelle:go_naming_convention import_alias
# gazelle:proto disable

gazelle(name = "gazelle")

gazelle(
    name = "gazelle-update-repos",
    args = [
        "-from_file=go.mod",
        "-to_macro=go_repositories.bzl%go_dependencies",
        "-prune",
        "-build_file_proto_mode=disable",
    ],
    command = "update-repos",
)

go_library(
    name = "common",
    srcs = ["doc.go"],
    importpath = "github.com/prometheus/common",
    visibility = ["//visibility:public"],
)

alias(
    name = "go_default_library",
    actual = ":common",
    visibility = ["//visibility:public"],
)
