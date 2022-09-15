const BREWERIES = {};

const handleResponse = (breweries) => {
  BREWERIES.list = breweries;
  BREWERIES.show();
};

const createTableRow = (brewery) => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");
  const breweryname = tr.appendChild(document.createElement("td"));
  breweryname.innerHTML = brewery.name;
  const year = tr.appendChild(document.createElement("td"));
  year.innerHTML = brewery.year;
  const beercount = tr.appendChild(document.createElement("td"));
  beercount.innerHTML = brewery.beers.count;
  const active = tr.appendChild(document.createElement("td"));
  active.innerHTML = brewery.active;

  return tr;
};

BREWERIES.show = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove());
  const table = document.getElementById("brewerytable");

  BREWERIES.list.forEach((brewery) => {
    const tr = createTableRow(brewery);
    table.appendChild(tr);
  });
}

BREWERIES.sortByName = () => {
  BREWERIES.list.sort((a, b) => a.name.toUpperCase().localeCompare(b.name.toUpperCase()));
};

BREWERIES.sortByYear = () => {
  BREWERIES.list.sort((a, b) => a.year < b.year);
};

BREWERIES.sortByBeerCount = () => {
  BREWERIES.list.sort((a, b) => a.beers.count < b.beers.count);
};

const makeSortable = () => {
  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByName();
    BREWERIES.show();
  });

  document.getElementById("year").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByYear();
    BREWERIES.show();
  });

  document.getElementById("beercount").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByBeerCount();
    BREWERIES.show();
  });
}

const getBreweries = async () => {
  const breweries = await fetch("breweries.json");

  return breweries.json();
}

const breweries = async () => {
  if (document.querySelectorAll("#brewerytable").length < 1) return;

  const breweries = await getBreweries();

  makeSortable()
  handleResponse(breweries)
}

export { breweries };
