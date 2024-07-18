import React from 'react';
import { useSelector } from 'react-redux';

import { makeStyles } from '@material-ui/core/styles';

import Fade from '@material-ui/core/Fade';
import CircularProgress from '@material-ui/core/CircularProgress';
import Box from '@material-ui/core/Box';

const useStyles = makeStyles({
  root: {
    color: props => props.color,
  },
  text: {
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    borderRadius: 25,
  },
  spacing: {
    marginLeft: props => (props.name === 'healthbar' ? 0 : 4),
  },
});

export default props => {
  const value = useSelector(state => state.app[props.name]);
  const display = useSelector(state => state.app.display[props.name]);
  const classes = useStyles(props);

  return !display ? null : (
    <Fade in={display} timeout={500}>
      <Box
        className={classes.spacing}
        position="relative"
        display="inline-flex"
      >
        <CircularProgress
          className={`${classes.root} ${classes.text}`}
          variant="static"
          size={50}
          value={value}
        />
        <Box
          top={0}
          left={0}
          bottom={0}
          right={0}
          position="absolute"
          display="flex"
          alignItems="center"
          justifyContent="center"
          className={classes.root}
        >
          {props.children}
        </Box>
      </Box>
    </Fade>
  );
};
