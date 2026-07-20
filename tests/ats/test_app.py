from pykube import Service
from pytest import mark
from pytest_helm_charts.clusters import Cluster
from pytest_helm_charts.giantswarm_app_platform.app import wait_for_apps_to_run
from pytest_helm_charts.k8s.deployment import wait_for_deployments_to_run


@mark.smoke
def test_dicebear_running(kube_cluster: Cluster) -> None:
    assert kube_cluster.kube_client is not None

    # Wait for the dicebear app and deployment to reach running state.
    # The deployment timeout is generous to absorb the first image pull in kind.
    wait_for_apps_to_run(kube_cluster.kube_client, ["dicebear"], "dicebear", 60)
    wait_for_deployments_to_run(kube_cluster.kube_client, ["dicebear"], "dicebear", 120)


@mark.smoke
def test_avatar_renders(kube_cluster: Cluster) -> None:
    assert kube_cluster.kube_client is not None

    service = Service.objects(kube_cluster.kube_client).filter(namespace="dicebear").get(name="dicebear")

    # The initials SVG endpoint should render for any seed (verified: 200).
    response = service.proxy_http_get("/10.x/initials/svg?seed=test")

    assert response.status_code == 200
