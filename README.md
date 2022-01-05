# The SPT Chart Library for Kubernetes

A library of [Helm](https://helm.sh) charts used to install [Quadient® Inspire](https://www.quadient.com/intelligent-communication/customer-communications2) and related applications used by the Global Strategic Projects Team to provide demo support services (via [Kubernetes](https://kubernetes.io)).

## Getting Started

```bash
> git clone https://github.com/robertwtucker/spt-charts charts
```

The previous command creates a local, working copy of the repository in a directory named `charts`. To deploy applications with Helm using the one of the charts provided (i.e. `hello`), issue the following command from the `charts` directory:

```bash
> helm upgrade --install test-release hello
```

Using the `--install` parameter with the `upgrade` command creates a new deployment if one does not already exist. Otherwise, it applies changes (if any) to the existing deployment.

For more information about using Helm and commands available, please see the [Helm documentation](https://helm.sh/docs/intro/using_helm/).

## Roadmap

See the [open issues](https://github.com/robertwtucker/spt-charts/issues) for a list of proposed features (and known issues).

## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b chart/AmazingApp`)
3. Commit your Changes (`git commit -m 'Add chart for AmazingApp'`)
4. Push to the Branch (`git push origin chart/AmazingApp`)
5. Open a Pull Request

## License

Copyright (c) 2021 Quadient Group AG and distributed under the MIT License. See `LICENSE` for more information.

## Contact

Robert Tucker - [@robertwtucker](https://twitter.com/robertwtucker)

Project Link: [https://github.com/robertwtucker/spt-charts](https://github.com/robertwtucker/spt-charts)

## Acknowledgements

- [Helm](https://helm.sh)
- [Bitnami](https://bitnami.com/)
