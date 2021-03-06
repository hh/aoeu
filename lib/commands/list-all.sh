list_all_command() {
  local package_name=$1
  local plugin_path=$(get_plugin_path $package_name)
  check_if_plugin_exists $plugin_path
  local versions=$( ${plugin_path}/bin/list-all )

  IFS=' ' read -a versions_list <<< "$versions"

  for version in "${versions_list[@]}"
  do
    echo "${version}"
  done
}
