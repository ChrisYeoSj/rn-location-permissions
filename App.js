import React, {Component} from 'react';
import { StyleSheet, Text, View, TouchableHighlight, NativeModules } from 'react-native';

export default class App extends Component {

  constructor(props){
    super(props);
    this._onPressButton = this._onPressButton.bind(this);
    this.state = {
      authorisationStatus: null,
    }
  }

  async _onPressButton(){
      const {LocationRequestHandler} = NativeModules;
      LocationRequestHandler.requestLocationPermission();
      const authorisationStatus = await LocationRequestHandler.getLocationStatus();
      this.setState({authorisationStatus})
  }

  render() {
    let authorisationStatus = null;
    if (this.state.authorisationStatus){
      authorisationStatus = (
        <Text>{this.state.authorisationStatus}</Text>
      )
    }
    return (
      <View style={styles.container}>
        <TouchableHighlight onPress={this._onPressButton}>
          <Text>Request Permission</Text>
        </TouchableHighlight>
        {authorisationStatus}
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
