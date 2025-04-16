import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:http/http.dart' as http;

class IpModel extends ChangeNotifier {
  String _response = '';
  bool _isLoading = false;
  String _error = '';
  String _ipAddress = '';

  String get ipAddress => _ipAddress;

  set ipAddress(String value) {
    _ipAddress = value;
    notifyListeners();
  }

  String get response => _response;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchData(String ip) async {
    _isLoading = true;
    _error = '';
    notifyListeners();
    _ipAddress = ip;
    try {
      final response = await http.get(Uri.parse('http://$ip'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        _response = response.body;
        var decodedJson = json.decode(_response);
        print('Decoded JSON: ${json.encode(decodedJson)}');
      } else {
        _error = 'Failed to load data';
      }
    } catch (e) {
      _error = e.toString();
      print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> GetReq(String s) async {
    try {
      final response = await http.get(Uri.parse('http://$_ipAddress/$s'));
    } catch (e) {
      _error = e.toString();
      print(_error);
    }
  }
}
