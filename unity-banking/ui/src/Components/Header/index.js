import React from 'react';

import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import IconButton from '@material-ui/core/IconButton';
import CloseIcon from '@material-ui/icons/Close';

import { makeStyles } from '@material-ui/core/styles';

import red from '@material-ui/core/colors/red';
import logo from './fleeca-logo.png';
import Nui from '../../util/Nui';

const useStyles = makeStyles({
  root: {
    flexGrow: 1,

    '& img': {
      width: 175,
    },
  },
  closeButton: {
    color: red[800],
  },
  title: {
    flexGrow: 1,
  },
});

const Header = () => {
  const classes = useStyles();

  const closeUI = async () => {
    await Nui.send('close');
  };

  return (
    <div className={classes.root}>
      <AppBar color="transparent" position="static">
        <Toolbar>
          <img src={logo} alt="logo"></img>
          <div className={classes.title}></div>
          <IconButton onClick={closeUI} className={classes.closeButton}>
            <CloseIcon />
          </IconButton>
        </Toolbar>
      </AppBar>
    </div>
  );
};

export default Header;
