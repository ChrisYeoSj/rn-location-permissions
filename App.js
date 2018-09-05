import React, {Component} from 'react';
import { StyleSheet, Text, View, TouchableHighlight, NativeModules } from 'react-native';

const LOCATION_REQUEST = {
    NOT_DETERMINED: 'NotDetermined',
    RESTRICTED: 'Restricted',
    AUTHORIZED_ALWAYS: 'AuthorizedAlways',
    AUTHORIZED_WHEN_IN_USE: 'AuthorizedWhenInUse',
    DENIED: 'Denied',
};

export default class App extends Component {

  constructor(props){
    super(props);
    this._onPressButton = this._onPressButton.bind(this);
    this.state = {
      authorisationStatus: null,
    }
  }

  async _onPressButton(){
      const { LocationRequestHandler } = NativeModules;
      const currentStatus = await LocationRequestHandler.getLocationStatus();
      if (currentStatus === LOCATION_REQUEST.NOT_DETERMINED) {
            console.log('requesting');
            const status = await LocationRequestHandler.requestLocationPermission();
            console.log('return status,', status);
      };
      const authorisationStatus = await LocationRequestHandler.getLocationStatus();
      console.log(typeof authorisationStatus);
      console.log('authorisationStatus:', authorisationStatus);
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
          <Text style={{color: 'blue'}}>Request Permission</Text>
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
