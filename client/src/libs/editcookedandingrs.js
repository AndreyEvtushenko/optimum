import { getCookedObjForSending, getIngrsForSending, nutrValues100 } 
  from '../libs/cookedform.js';
import request from '../libs/requests.js';

export default async function(editable, editedCooked, editedIngrs) {
  const whatToUpdate = detectChanges(editable, editedCooked, editedIngrs);
  if(whatToUpdate == 'nothing') {
    return 'Nothing changed';
  }
  if(whatToUpdate == 'cooked') {
    const result = await updateCooked(editedCooked);
    return processUpdateCookedResult(result, editable, editedCooked);
  }
  if(whatToUpdate == 'whole') {
    const result = await updateCookedAndIngrs(editedCooked, editedIngrs);
    return processUpdateCookedAndIngrsResult(result, editable, 
      editedCooked, editedIngrs);
  }
}

function detectChanges(editable, editedCooked, editedIngrs) {
  const cooked = cookedWasChanged(editable, editedCooked);
  let ingridients = false;

  if(!ingrCountWasChanged(editable, editedIngrs)) {
    ingridients = ingridientsWereChanged(editable, editedIngrs);
  } else {
    ingridients = true;
  }

  return whatToUpdate(cooked, ingridients);
}

function cookedWasChanged(editable, editedCooked) {
  if(editable.name != editedCooked.name)
    return true;
  if(editable.weight != editedCooked.weight)
    return true;
  return false;
}

function ingrCountWasChanged(editable, editedIngrs) {
  if(editable.ingridients.length != countIngridients(editedIngrs))
    return true;
  return false;
}

function countIngridients(editedIngrs) {
  let count = 0;
  for(let ingridient of editedIngrs) {
    if(ingridient.nutrValuesW) {
      count++;
    }
  }
  return count;
}

function ingridientsWereChanged(editable, editedIngrs) {
  const edited = Array.from(editedIngrs);
  const initial = editable.ingridients;

  for(let ingr of initial) {
    const finded = edited.find(item => item.id == ingr.id);
    if(!finded)
      return true;
    if(finded.weight != ingr.weight)
      return true;
  }
  return false;
}

function whatToUpdate(cooked, ingridients) {
  if(cooked && ingridients)
    return 'whole';
  if(ingridients)
    return 'whole'; 
  if(cooked)
    return 'cooked';
  return 'nothing';
}

function updateCooked(cooked) {
  const id = cooked.id;
  const URL = `/api/cooked/${id}`;
  const cookedForSending = getCookedObjForSending(cooked);
  delete cookedForSending.date;

  return request.patch(URL, cookedForSending);
}

function processUpdateCookedResult(result, editable, editedCooked) {
  if(result == 0) {
    return 'Nothing changed';
  } else if(result == 1) {
    updateCookedList(editable, editedCooked)
    return 'Changes were saved';
  }
}

function updateCookedList(editable, editedCooked) {
  const nutrValues = nutrValues100(editedCooked.nutrValues1);
  editable.name = editedCooked.name;
  editable.weight = editedCooked.weight;  
  editable.kcal = nutrValues[0];
  editable.proteins = nutrValues[1];
  editable.fats = nutrValues[2];
  editable.carbohydrates = nutrValues[3];
}

function updateCookedAndIngrs(cooked, ingridients) {
  const id = cooked.id;
  const URL = `/api/cooked/whole/${id}`;
  const cookedForSending = getCookedObjForSending(cooked);
  delete cookedForSending.date;
  cookedForSending.ingridients =  getIngrsForSending(ingridients);

  return request.patch(URL, cookedForSending);
}

function processUpdateCookedAndIngrsResult(result, editable, 
  editedCooked, editedIngrs) {
  if(!result) {
    return 'Changes weren\'t saved';
  } else if(result) {
    updateCookedList(editable, editedCooked);
    updateIngrsInCookedList(editable, editedIngrs);
    return 'Changes were saved';
  }
}

function updateIngrsInCookedList(editable, editedIngrs) {
  const newIngridients = getNewIngrsForList(editedIngrs);

  for(let ingridient of newIngridients) {
    Object.assign(ingridient, ingridient.nutrValues1);
    delete ingridient.listId;
    delete ingridient.nutrValues1;
    delete ingridient.nutrValuesW;
  }
  editable.ingridients = newIngridients;
}

function getNewIngrsForList(editedIngrs) {
  const newIngridients = new Set(editedIngrs);
  for(let ingridient of newIngridients) {
    if(!ingridient.nutrValuesW) {
      newIngridients.delete(ingridient);
    }
  }
  return Array.from(newIngridients);
}