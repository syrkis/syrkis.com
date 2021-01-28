var p= document.getElementById('lorem'),
	    clone= document.createElement('p');

clone.textContent= p.textContent;
clone.className= 'clone';
p.parentNode.insertBefore(clone, p);
p.style.height= p.offsetHeight - 14 + 'px';
