# DEPRECATED as of September 2, 2022

The ArgoCD repository now houses all of the charts we use for deployment.
This respository is not to be used, but is being left open for a bit. 
Once it is determined not to be of use any more, it will be archived.

# Using this repository

To install a Helm chart from this repository first add the repository:

```
helm repo add lsstts https://lsst-ts.github.io/charts/
helm repo update
```

## Installing charts

Use the `helm install` command to install the charts:

```
helm install lsstts/mychart --name myrelease
```

See the [Helm Documentation](https://github.com/helm/helm/tree/master/docs) for more information.

# Adding a new chart to this repository

This command will create  a [collection of files](https://github.com/helm/helm/blob/master/docs/charts.md#the-chart-file-structure) that defines your chart:

```
helm create mychart
```

## Templates

Helm finds the YAML definitions for your Kubernetes objects in the `templates/` directory. Helm runs each file in this directory through a Go template rendering engine.

## Values

The `values.yaml` file defines the defaults for each template variable.

## Documentation

Another useful file in the `templates/` directory is the `NOTES.txt` file. It is a templated, plaintext file that gets printed out after the chart is successfully deployed.


# Debugging your chart

As you develop your chart, it’s a good idea to run it through the linter to ensure you’re following best practices and that your templates are well-formed:

```
helm lint mychart
```

A convenient command to debug your new chart is:

```
helm install --dry-run --debug mychart
```

# Packaging your chart

Your chart will be packaged and released automatically once the chart has been merged into the `master` branch.
This is done via a GitHub Action configured in `.github/workflows/release.yaml`.
The release will then be automatically added to the repository index at https://lsst-ts.github.io/charts/.

# Re-adding an old chart

Any old charts that were not current when this repository was converted to autom
ated releases are not published or in the index.
However, it may be necessary to go back and republish old charts to revert changes.
Here is the (fairly manual) process for doing that.

1. Find the old released chart.
   This should be available in an old Git revision.
   It will be a file named `<chart>-<version>.tgz`.
2. Create a new Git tag at the revision from which you're pulling the chart.
   The tag should be `<chart>-<version>`.
   Push that tag to GitHub.
3. Create a new GitHub release from that tag and upload the `.tgz` file (originally generated by `helm release`) as an artifact for that tag.
   The description of the release is the description line from the Helm chart.
4. Get a copy of [chart-releaser](https://github.com/helm/chart-releaser).
   You can download the `cr` binary or use the process documented there to build
 it yourself.
5. Check out the `gh-pages` branch of the `lsst-ts/charts` repository.
6. Create a directory named `.cr-release-packages` and put the `.tgz` file of the chart you want to restore in that directory.
7. Run `cr index -i index.yaml -o lsst-ts -r charts -c https://lsst-ts.github.io/charts/`.
8. Verify the resulting `index.yaml` file contains the restored chart metadata and no other changes (in particular, that it's not missing any other chart metadata that was previously there).
9. Commit and push the `index.yaml` file.

⎈ Happy Helming!⎈
