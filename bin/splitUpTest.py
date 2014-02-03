#!/usr/bin/python

import os, sys
import re
import hashlib
from glob import glob

target_file = 'RemoteUtilsTest.cls'
f = open(target_file, 'r')
test_contents = f.read()
f.close()

methods = test_contents.split('static testMethod')
methods.pop(0)
methods[-1] = re.sub(r'\n}', '', methods[-1])

testTemplate = """
/**
* Testing for %s (from %s)
*/
@isTest
private class %s {
%sstatic testMethod%s
}
"""

testTemplateXML = """
<?xml version="1.0" encoding="UTF-8"?>
<ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
    <apiVersion>29.0</apiVersion>
    <status>Active</status>
    <packageVersions>
        <majorNumber>1</majorNumber>
        <minorNumber>10</minorNumber>
        <namespace>AAA</namespace>
    </packageVersions>
</ApexClass>
"""

for old_test_file in glob('AAA_*'):
    os.unlink(old_test_file)

m = hashlib.md5()

md5_method_name_to_method_hash = {}
for method in methods:
    method_lines = re.split(r'\n', method)
    top_of_method = method_lines[0]
    groups = re.search(r'(\w*)\(\s*\)', top_of_method)
    original_method_name = groups.group(1).lower()
    m.update(method)
    md5_method_name = m.hexdigest()
    md5_method_name_to_method_hash[md5_method_name] = {
        'method' : method,
        'method_name' : original_method_name
    }

for (md5_method_name, struct) in md5_method_name_to_method_hash.items():
    method = struct['method']
    method_name = struct['method_name']
    test_class_name = 'AAA_%s' % (md5_method_name,)
    test_class_name = test_class_name[:39]
    test_class_name = re.sub(r'_+$', '', test_class_name)

    test_class_file_name = '%s.cls' % (test_class_name,)
    test_class_xml_file_name = '%s-meta.xml' % (test_class_file_name,)

    testContents = testTemplate % (method_name, target_file, test_class_name, '\t', method)
    # print testContents

    testXML = testTemplateXML

    f = open(test_class_file_name, 'w')
    f.write(testContents.strip())
    f.close()

    f = open(test_class_xml_file_name, 'w')
    f.write(testXML.strip())
    f.close()

    print test_class_name