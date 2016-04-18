// USAGE: rdfpro @read INPUT_FILE @groovy -p gen_definedBy.groovy @unique @write OUTPUT_FILE

import org.openrdf.model.*;
import org.openrdf.model.impl.*;

def init(args) {
  graph = <http://www.newsreader-project.eu/modules/tbox>;
  definedBy = rdfs:isDefinedBy;
  classDefinedBy = <http://dkm.fbk.eu/ontologies/newsreader#isClassDefinedBy>;
  propertyDefinedBy = <http://dkm.fbk.eu/ontologies/newsreader#isPropertyDefinedBy>;
  eventClassDefinedBy = <http://dkm.fbk.eu/ontologies/newsreader#isEventClassDefinedBy>;
  rolePropertyDefinedBy = <http://dkm.fbk.eu/ontologies/newsreader#isRolePropertyDefinedBy>;
  situationPropertyDefinedBy = <http://dkm.fbk.eu/ontologies/newsreader#isSituationPropertyDefinedBy>;
}

def annotate(URI concept, URI... properties) {
  URI ns = ValueFactoryImpl.getInstance().createURI(concept.getNamespace());
  for (URI property : properties) {
    emit(concept, property, ns, graph);
  }
}

annotate(p, propertyDefinedBy, definedBy);
if (o instanceof URI) {
  boolean isType = p.equals(rdf:type) ;
  if (isType) {
    annotate(o, classDefinedBy, definedBy);
  } 
  if (s instanceof URI) {
    if (isType) {
      if (o.equals(rdfs:Class) || o.equals(owl:Class)) {
        annotate(s, classDefinedBy, definedBy);
      } else if (o.equals(owl:ObjectProperty) || o.equals(owl:DatatypeProperty) || o.equals(owl:AnnotationProperty) || o.equals(rdf:Property)) {
        annotate(s, propertyDefinedBy, definedBy);
      }
    } else if (p.equals(rdfs:subPropertyOf)) {
      if (o.equals(eso:hasRole)) {
        annotate(s, rolePropertyDefinedBy, propertyDefinedBy, definedBy);
      } else if (o.equals(eso:binaryProperty) || o.equals(eso:unaryProperty)) {
        annotate(s, situationPropertyDefinedBy, propertyDefinedBy, definedBy);
      }
    } else if (p.equals(rdfs:subClassOf)) {
      if (o.equals(eso:StaticEvent) || o.equals(eso:DynamicEvent)) {
        annotate(s, eventClassDefinedBy, classDefinedBy, definedBy);
      }
    }
  }
}
