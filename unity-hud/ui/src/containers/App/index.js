import React from 'react';
import { useSelector } from 'react-redux';

import {
  createMuiTheme,
  ThemeProvider,
  makeStyles,
} from '@material-ui/core/styles';

import CssBaseline from '@material-ui/core/CssBaseline';

import LocalHospitalIcon from '@material-ui/icons/LocalHospital';
import OpacityIcon from '@material-ui/icons/Opacity';
import SecurityIcon from '@material-ui/icons/Security';
import RestaurantIcon from '@material-ui/icons/Restaurant';
import LocalDrinkIcon from '@material-ui/icons/LocalDrink';
import InsertEmoticonIcon from '@material-ui/icons/InsertEmoticon';
import SentimentSatisfiedIcon from '@material-ui/icons/SentimentSatisfied';
import SentimentVeryDissatisfiedIcon from '@material-ui/icons/SentimentVeryDissatisfied';
import BubbleChartOutlinedIcon from '@material-ui/icons/BubbleChartOutlined';
import SignalWifi1BarIcon from '@material-ui/icons/SignalWifi1Bar';
import SignalWifi2BarIcon from '@material-ui/icons/SignalWifi2Bar';
import SignalWifi4BarIcon from '@material-ui/icons/SignalWifi4Bar';

import HudComponent from '../../components/HudComponent';
import Settings from '../../components/Settings';

const theme = createMuiTheme({
  palette: {
    type: 'dark',
  },
});

const useStyles = makeStyles({
  root: {
    position: 'fixed',
    left: '50%',
    bottom: '3%',
    transform: 'translate(-50%, -50%)',
    margin: '0 auto',
  },
  spacing: {
    marginLeft: '50px',
  },
});

const App = () => {
  const stress = useSelector(state => state.app.stressbar);
  const voice = useSelector(state => state.app.voicebar);
  const bleedAmount = useSelector(state => state.app.bleedAmount);
  const classes = useStyles();

  return (
    <>
      <ThemeProvider theme={theme}>
        <Settings />
        <div className={classes.root}>
          <CssBaseline />
          <HudComponent name="healthbar" color="#e53935">
            {bleedAmount > 0 ? <OpacityIcon /> : <LocalHospitalIcon />}
          </HudComponent>
          <HudComponent name="armorbar" color="#2196f3">
            <SecurityIcon />
          </HudComponent>
          <HudComponent name="foodbar" color="#f4511e">
            <RestaurantIcon />
          </HudComponent>
          <HudComponent name="waterbar" color="#9adcfb">
            <LocalDrinkIcon />
          </HudComponent>
          <HudComponent name="stressbar" color="#c62828">
            {stress < 33 ? (
              <InsertEmoticonIcon />
            ) : stress < 66 ? (
              <SentimentSatisfiedIcon />
            ) : (
              <SentimentVeryDissatisfiedIcon />
            )}
          </HudComponent>
          <HudComponent name="oxygenbar" color="#ec407a">
            <BubbleChartOutlinedIcon />
          </HudComponent>
          <HudComponent name="voicebar" color="#1a73e8">
            {voice === 33 ? (
              <SignalWifi1BarIcon />
            ) : voice === 66 ? (
              <SignalWifi2BarIcon />
            ) : (
              <SignalWifi4BarIcon />
            )}
          </HudComponent>
        </div>
      </ThemeProvider>
    </>
  );
};

export default App;
