// create a function to shuffle a list
// essential for counterbalancing abstract stimuli
// before assigning any physical stimuli (like img or words)
function shuffle(a) {
  var j, x, i;
  for (i = a.length - 1; i > 0; i--) {
      j = Math.floor(Math.random() * (i + 1));
      x = a[i];
      a[i] = a[j];
      a[j] = x;
  }
  return a;
}

//create a list
x = [1,2,3,4,5,6,7,8] 

// and shuffle it
shuffle(x)
