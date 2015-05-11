source $(dirname $(dirname $0))/lib/utils.sh

package=$1
full_version=$2
source_path=$(get_source_path $package)

check_if_source_exists $source_path
if [ ! -d "$source_path/$full_version" ]
then
  display_error "No such version"
  exit 1
fi

IFS=':' read -a version_info <<< "$full_version"
if [ "${version_info[0]}" = "tag" ] || [ "${version_info[0]}" = "commit" ]
  then
  install_type="${version_info[0]}"
  version="${version_info[1]}"
else
  install_type="version"
  version="${version_info[0]}"
fi

install_path=$(get_install_path $package $install_type $version)

if [ -f ${source_path}/bin/uninstall ]
then
  ${source_path}/bin/uninstall $install_type $version $install_path "${@:3}"
else
  rm -rf $install_path
fi