import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ArModels {
  ArCoreController arCoreController = ArCoreController();
  ArCoreNode? node;

  dynamic onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _addChair(controller);
    _addToon2(controller);
  }

  _handleOnPlaneDetected(ArCorePlane plane) {
    if (node != null) {
      arCoreController.removeNode(nodeName: node?.name);
    }
    _addSphere(arCoreController, plane);
  }

  _addToon(ArCoreController controller, ArCorePlane plane) {
    node = ArCoreReferenceNode(
        name: 'Toon',
        object3DFileName: 'Toon.sfb',
        scale: vector.Vector3(0.8, 0.8, 0.8),
        position: plane.centerPose.translation,
        rotation: plane.centerPose.rotation);
  }

  _addToon2(ArCoreController controller) {
    final node = ArCoreReferenceNode(
      name: 'Toon2',
      object3DFileName: 'Toon.sfb',
      scale: vector.Vector3(0.7, 0.7, 0.7),
      position: vector.Vector3(3, -2, -2),
      rotation: vector.Vector4(0, 180, 0, 0),
    );
    controller.addArCoreNode(node);
  }

  _addEarth(ArCoreController controller) {
    final node = ArCoreReferenceNode(
      name: 'Earth',
      object3DFileName: 'Earth.sfb',
      scale: vector.Vector3(0.8, 0.8, 0.8),
      position: vector.Vector3(0, -1, -1),
      rotation: vector.Vector4(0, 180, 0, 0),
    );
    controller.addArCoreNode(node);
  }

  _addChair(ArCoreController controller) {
    final node = ArCoreReferenceNode(
      name: 'Chair',
      object3DFileName: 'testchair.sfb',
      scale: vector.Vector3(0.5, 0.5, 0.5),
      position: vector.Vector3(0, -1, -1),
      rotation: vector.Vector4(0, 0, 0, 0),
    );
    controller.addArCoreNode(node);
  }

  _addSphere(ArCoreController controller, ArCorePlane plane) {
    final material =
        ArCoreMaterial(color: const Color.fromARGB(255, 224, 155, 178));
    final sphere = ArCoreSphere(materials: [material], radius: 0.2);
    node = ArCoreNode(
        name: 'sphere',
        shape: sphere,
        position: plane.centerPose.translation,
        rotation: plane.centerPose.rotation);
    controller.addArCoreNode(node);
  }

  arDispose() {
    arCoreController.dispose();
  }
}
