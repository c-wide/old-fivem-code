import React from 'react';
import { useSelector } from 'react-redux';
import { HashRouter, Redirect, Route, Switch } from 'react-router-dom';

import {
  createMuiTheme,
  ThemeProvider,
  makeStyles,
} from '@material-ui/core/styles';

import CssBaseline from '@material-ui/core/CssBaseline';
import Fade from '@material-ui/core/Fade';

import Header from '../../Components/Header';
import Bank from '../Bank';
import ATM from '../ATM';

const theme = createMuiTheme({
  palette: {
    primary: {
      main: '#1a7cc1',
    },
    background: {
      default: '#303030',
      paper: '#303030',
    },
    type: 'dark',
  },
});

const useStyles = makeStyles({
  root: {
    width: 900,
    height: 420,
    position: 'absolute',
    top: 0,
    bottom: 0,
    right: 0,
    left: 0,
    margin: 'auto',
    overflow: 'none',
    background: theme.palette.background.default,
  },
});

const App = () => {
  const hidden = useSelector(state => state.app.hidden);
  const route = useSelector(state => state.app.route);

  const classes = useStyles();

  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <HashRouter>
        <Fade in={!hidden} timeout={250}>
          <div className={classes.root}>
            <Header />
            <Switch>
              <Route exact key="bank" path="/bank">
                <Bank />
              </Route>
              <Route exact key="atm" path="/atm">
                <ATM />
              </Route>
            </Switch>
            <Redirect push to={`/${route}`} />
          </div>
        </Fade>
      </HashRouter>
    </ThemeProvider>
  );
};

export default App;
